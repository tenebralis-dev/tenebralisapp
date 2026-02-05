import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/api_connection.dart';
import 'controllers/connection_editor_controller.dart';
import 'widgets/api_key_field.dart';
import 'widgets/test_connection_button.dart';

class ConnectionEditorPage extends ConsumerStatefulWidget {
  const ConnectionEditorPage({
    super.key,
    this.editing,
  });

  final ConnectionListItem? editing;

  @override
  ConsumerState<ConnectionEditorPage> createState() => _ConnectionEditorPageState();
}

class _ConnectionEditorPageState extends ConsumerState<ConnectionEditorPage> {
  final _name = TextEditingController();
  final _baseUrl = TextEditingController();
  final _defaultModel = TextEditingController();
  final _systemPrompt = TextEditingController();
  final _paramsJson = TextEditingController(text: '{}');
  final _headersJson = TextEditingController(text: '{}');
  final _configJson = TextEditingController(text: '{}');
  final _apiKey = TextEditingController();

  bool _obscureApiKey = true;

  @override
  void dispose() {
    _name.dispose();
    _baseUrl.dispose();
    _defaultModel.dispose();
    _systemPrompt.dispose();
    _paramsJson.dispose();
    _headersJson.dispose();
    _configJson.dispose();
    _apiKey.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(connectionEditorControllerProvider.notifier).load(widget.editing);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(connectionEditorControllerProvider);

    state.whenData((s) {
      // Only sync from provider state when editing existing connection.
      // For new connection, keep user's input in controllers to avoid clearing.
      if (widget.editing != null) {
        _sync(s);
      }
    });

    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.editing == null ? '新增连接' : '编辑连接'),
        iconTheme: IconThemeData(color: scheme.onSurface),
        actionsIconTheme: IconThemeData(color: scheme.onSurface),
        titleTextStyle:
            Theme.of(context).textTheme.titleLarge?.copyWith(color: scheme.onSurface),
        actions: [
          IconButton(
            tooltip: '保存',
            onPressed: state.isLoading
                ? null
                : () async {
                    final ok = await _save();
                    if (ok && mounted) Navigator.of(context).pop();
                  },
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              '加载失败：$e',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
        data: (s) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _Card(
                title: '保存位置',
                subtitle: '开=云端同步，关=仅本地',
                child: SwitchListTile.adaptive(
                  value: s.saveToCloud,
                  onChanged: (v) => ref
                      .read(connectionEditorControllerProvider.notifier)
                      .setSaveToCloud(v),
                  title: Text(s.saveToCloud ? '保存到云端（Supabase）' : '仅本地（当前设备）'),
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                title: '基础信息',
                subtitle: '名称、类型、端点与启用状态',
                child: Column(
                  children: [
                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: '名称',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<ApiServiceType>(
                      value: s.base.serviceType,
                      decoration: const InputDecoration(
                        labelText: '服务类型',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      items: ApiServiceType.values
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(_serviceTypeLabel(t)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        ref
                            .read(connectionEditorControllerProvider.notifier)
                            .updateBase(s.base.copyWith(serviceType: v));
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _baseUrl,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: 'Base URL',
                        hintText: '例如：https://api.openai.com（可带 /v1，也可不带）',
                        prefixIcon: Icon(Icons.link_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile.adaptive(
                      value: s.base.isActive,
                      onChanged: (v) => ref
                          .read(connectionEditorControllerProvider.notifier)
                          .updateBase(s.base.copyWith(isActive: v)),
                      title: const Text('启用'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                title: '密钥',
                subtitle: '仅保存在本地安全存储，不会上传',
                child: Column(
                  children: [
                    ApiKeyField(
                      controller: _apiKey,
                      obscureText: _obscureApiKey,
                      onToggleObscure: () => setState(() => _obscureApiKey = !_obscureApiKey),
                      onCopy: _copyKey,
                      onClear: () => _apiKey.clear(),
                    ),
                    const SizedBox(height: 10),
                    TestConnectionButton(
                      isLoading: s.isTesting,
                      onPressed: s.isTesting ? null : _test,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                title: '模型与提示词（可选）',
                subtitle: '默认模型、system prompt',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Autocomplete<String>(
                            initialValue: TextEditingValue(text: _defaultModel.text),
                            optionsBuilder: (value) {
                              final q = value.text.trim().toLowerCase();
                              if (q.isEmpty) return s.models;
                              return s.models.where(
                                (m) => m.toLowerCase().contains(q),
                              );
                            },
                            onSelected: (v) => setState(() => _defaultModel.text = v),
                            fieldViewBuilder: (context, textController, focusNode, _) {
                              // Keep external controller in sync.
                              if (textController.text != _defaultModel.text) {
                                textController.text = _defaultModel.text;
                                textController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: textController.text.length),
                                );
                              }

                              if (s.models.isNotEmpty) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (!focusNode.hasFocus) {
                                    focusNode.requestFocus();
                                  }
                                });
                              }

                              return TextField(
                                controller: textController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: '默认模型',
                                  hintText: '可输入或从建议中选择',
                                  prefixIcon: Icon(Icons.model_training_outlined),
                                ),
                                onChanged: (v) => _defaultModel.text = v,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 110,
                          height: 48,
                          child: FilledButton.tonalIcon(
                            onPressed: s.isFetchingModels
                              ? null
                              : () async {
                                  final notifier = ref.read(
                                    connectionEditorControllerProvider.notifier,
                                  );
                                  final ss = await ref.read(
                                    connectionEditorControllerProvider.future,
                                  );
                                  final base = _buildBase(ss);
                                  final apiKey = _apiKey.text.trim();
                                  final error = notifier.validate(
                                    base: base,
                                    apiKey: apiKey,
                                  );
                                  if (error != null) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)),
                                    );
                                    return;
                                  }

                                  try {
                                    final models = await notifier.fetchModels(
                                      base: base,
                                      apiKey: apiKey,
                                    );
                                    if (!mounted) return;
                                    // Trigger rebuild so Autocomplete suggestions use latest models.
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('已拉取 ${models.length} 个模型'),
                                      ),
                                    );
                                  } catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('拉取失败：$e')),
                                    );
                                  }
                                },
                          icon: s.isFetchingModels
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.download_outlined),
                            label: const Text('拉取'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _systemPrompt,
                      minLines: 2,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'System Prompt',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.psychology_alt_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                title: '高级 JSON（无敏感信息）',
                subtitle: 'params / headers_template / config',
                child: Column(
                  children: [
                    TextField(
                      controller: _paramsJson,
                      minLines: 3,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: 'params_json',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.tune_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _headersJson,
                      minLines: 3,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: 'headers_template_json（禁止 Authorization/x-api-key）',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.http_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _configJson,
                      minLines: 3,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: 'config_json',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.settings_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _Hint(
                text:
                    '提示：切换“保存到云端”为关闭时，将创建一条本地副本；云端记录不会被删除（复制并存）。',
              ),
            ],
          );
        },
      ),
    );
  }

  void _sync(ConnectionEditorState s) {
    if (_name.text != s.base.name) _name.text = s.base.name;
    if (_baseUrl.text != s.base.baseUrl) _baseUrl.text = s.base.baseUrl;
    if ((_defaultModel.text) != (s.base.defaultModel ?? '')) {
      _defaultModel.text = s.base.defaultModel ?? '';
    }
    if ((_systemPrompt.text) != (s.base.systemPrompt ?? '')) {
      _systemPrompt.text = s.base.systemPrompt ?? '';
    }
    if (_paramsJson.text != const JsonEncoder.withIndent('  ').convert(s.base.params)) {
      _paramsJson.text = const JsonEncoder.withIndent('  ').convert(s.base.params);
    }
    if (_headersJson.text != const JsonEncoder.withIndent('  ').convert(s.base.headersTemplate)) {
      _headersJson.text = const JsonEncoder.withIndent('  ').convert(s.base.headersTemplate);
    }
    if (_configJson.text != const JsonEncoder.withIndent('  ').convert(s.base.config)) {
      _configJson.text = const JsonEncoder.withIndent('  ').convert(s.base.config);
    }
    if ((_apiKey.text) != (s.apiKey ?? '')) {
      _apiKey.text = s.apiKey ?? '';
    }
  }

  Future<void> _copyKey() async {
    final v = _apiKey.text.trim();
    if (v.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: v));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('密钥已复制到剪贴板')),
    );
  }

  ApiConnectionBase _buildBase(ConnectionEditorState s) {
    return s.base.copyWith(
      name: _name.text.trim(),
      baseUrl: _baseUrl.text.trim(),
      defaultModel: _defaultModel.text.trim().isEmpty ? null : _defaultModel.text.trim(),
      systemPrompt: _systemPrompt.text.trim().isEmpty ? null : _systemPrompt.text.trim(),
      params: _parseJsonMap(_paramsJson.text),
      headersTemplate: _parseJsonMap(_headersJson.text),
      config: _parseJsonMap(_configJson.text),
    );
  }

  Future<bool> _save() async {
    final notifier = ref.read(connectionEditorControllerProvider.notifier);
    final s = await ref.read(connectionEditorControllerProvider.future);

    final base = _buildBase(s);

    final error = notifier.validate(base: base, apiKey: _apiKey.text.trim());
    if (error != null) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return false;
    }

    try {
      await notifier.save(
        base: base,
        apiKey: _apiKey.text.trim().isEmpty ? null : _apiKey.text.trim(),
      );
    } catch (e) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失败：$e')),
      );
      return false;
    }

    if (!mounted) return true;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已保存')),
    );

    return true;
  }

  Future<void> _test() async {
    final notifier = ref.read(connectionEditorControllerProvider.notifier);
    final s = await ref.read(connectionEditorControllerProvider.future);
    final base = _buildBase(s);
    final apiKey = _apiKey.text.trim();

    final error = notifier.validate(base: base, apiKey: apiKey);
    if (error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    try {
      final result = await notifier.test(base: base, apiKey: apiKey);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ 连接可用（${result.latency}ms）${result.model == null ? '' : ' model=${result.model}'}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ 测试失败：$e')),
      );
    }
  }

  Map<String, dynamic> _parseJsonMap(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return <String, dynamic>{};

    final decoded = jsonDecode(trimmed);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
    throw FormatException('必须是 JSON 对象');
  }

  String _serviceTypeLabel(ApiServiceType t) {
    switch (t) {
      case ApiServiceType.openaiCompat:
        return 'openai_compat（LLM）';
      case ApiServiceType.stt:
        return 'stt（语音转文字）';
      case ApiServiceType.tts:
        return 'tts（文字转语音）';
      case ApiServiceType.image:
        return 'image（生成图）';
      case ApiServiceType.custom:
        return 'custom（自定义）';
    }
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: scheme.onSurfaceVariant),
    );
  }
}
