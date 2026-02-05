-- =====================================================
-- Tenebralis Dream System - Database Schema
-- =====================================================
-- Run this SQL in your Supabase SQL Editor
-- https://supabase.com/dashboard/project/_/sql

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- 1. PROFILES TABLE (User Data)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    global_points INTEGER DEFAULT 0,
    preferences JSONB DEFAULT '{"theme": "dark", "language": "zh", "notificationsEnabled": true, "soundEnabled": true, "hapticEnabled": true}'::jsonb,
    inventory JSONB DEFAULT '{"items": [], "achievements": [], "unlockedWorlds": [], "currencies": {}}'::jsonb,
    current_session JSONB DEFAULT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_profiles_id ON public.profiles(id);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- RLS Policies for profiles
CREATE POLICY "Users can view own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
    ON public.profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id);

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id)
    VALUES (NEW.id)
    ON CONFLICT (id) DO NOTHING;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS profiles_updated_at ON public.profiles;
CREATE TRIGGER profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- 2. WORLDS TABLE (Game Settings/Worlds)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.worlds (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    genre TEXT NOT NULL DEFAULT 'fantasy',
    description TEXT,
    cover_image TEXT,
    settings JSONB DEFAULT '{}'::jsonb,
    initial_state JSONB DEFAULT '{}'::jsonb,
    is_public BOOLEAN DEFAULT FALSE,
    creator_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_worlds_creator ON public.worlds(creator_id);
CREATE INDEX IF NOT EXISTS idx_worlds_public ON public.worlds(is_public);
CREATE INDEX IF NOT EXISTS idx_worlds_genre ON public.worlds(genre);

-- Enable RLS
ALTER TABLE public.worlds ENABLE ROW LEVEL SECURITY;

-- RLS Policies for worlds
CREATE POLICY "Anyone can view public worlds"
    ON public.worlds FOR SELECT
    USING (is_public = TRUE);

CREATE POLICY "Users can view own worlds"
    ON public.worlds FOR SELECT
    USING (auth.uid() = creator_id);

CREATE POLICY "Users can create worlds"
    ON public.worlds FOR INSERT
    WITH CHECK (auth.uid() = creator_id);

CREATE POLICY "Users can update own worlds"
    ON public.worlds FOR UPDATE
    USING (auth.uid() = creator_id);

CREATE POLICY "Users can delete own worlds"
    ON public.worlds FOR DELETE
    USING (auth.uid() = creator_id);

-- Trigger for updated_at
DROP TRIGGER IF EXISTS worlds_updated_at ON public.worlds;
CREATE TRIGGER worlds_updated_at
    BEFORE UPDATE ON public.worlds
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- 3. CHRONICLES TABLE (Timeline/Chat History)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.chronicles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    world_id UUID REFERENCES public.worlds(id) ON DELETE SET NULL,
    type TEXT NOT NULL CHECK (type IN ('chat', 'memo', 'transaction')),
    content JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_chronicles_user ON public.chronicles(user_id);
CREATE INDEX IF NOT EXISTS idx_chronicles_world ON public.chronicles(world_id);
CREATE INDEX IF NOT EXISTS idx_chronicles_type ON public.chronicles(type);
CREATE INDEX IF NOT EXISTS idx_chronicles_created ON public.chronicles(created_at DESC);

-- Enable RLS
ALTER TABLE public.chronicles ENABLE ROW LEVEL SECURITY;

-- RLS Policies for chronicles
CREATE POLICY "Users can view own chronicles"
    ON public.chronicles FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own chronicles"
    ON public.chronicles FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own chronicles"
    ON public.chronicles FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own chronicles"
    ON public.chronicles FOR DELETE
    USING (auth.uid() = user_id);

-- Trigger for updated_at
DROP TRIGGER IF EXISTS chronicles_updated_at ON public.chronicles;
CREATE TRIGGER chronicles_updated_at
    BEFORE UPDATE ON public.chronicles
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- 4. RELATIONSHIPS TABLE (NPC/Quest States)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.relationships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    world_id UUID NOT NULL REFERENCES public.worlds(id) ON DELETE CASCADE,
    target_type TEXT NOT NULL CHECK (target_type IN ('npc', 'quest')),
    target_key TEXT NOT NULL,
    value INTEGER DEFAULT 0,
    state JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    -- Unique constraint for upsert
    UNIQUE(user_id, world_id, target_type, target_key)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_relationships_user ON public.relationships(user_id);
CREATE INDEX IF NOT EXISTS idx_relationships_world ON public.relationships(world_id);
CREATE INDEX IF NOT EXISTS idx_relationships_target ON public.relationships(target_type, target_key);

-- Enable RLS
ALTER TABLE public.relationships ENABLE ROW LEVEL SECURITY;

-- RLS Policies for relationships
CREATE POLICY "Users can view own relationships"
    ON public.relationships FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own relationships"
    ON public.relationships FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own relationships"
    ON public.relationships FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own relationships"
    ON public.relationships FOR DELETE
    USING (auth.uid() = user_id);

-- Trigger for updated_at
DROP TRIGGER IF EXISTS relationships_updated_at ON public.relationships;
CREATE TRIGGER relationships_updated_at
    BEFORE UPDATE ON public.relationships
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- 5. SAMPLE DATA (Optional - for testing)
-- =====================================================

-- Insert sample public worlds
INSERT INTO public.worlds (name, genre, description, is_public, settings, initial_state)
VALUES
    (
        '星际迷途',
        'sci-fi',
        '在遥远的未来，人类已经殖民了银河系。你是一名星际探险家，发现了一个神秘的信号来源...',
        TRUE,
        '{"system_prompt": "你是一个科幻世界的AI叙述者。场景设定在2487年的银河系。用富有想象力的语言描述未来科技和星际冒险。", "npcs": [{"key": "captain", "name": "舰长艾拉", "personality": "冷静理性，经验丰富"}, {"key": "ai", "name": "量子AI", "personality": "逻辑严密，偶尔幽默"}], "quests": [{"key": "signal", "title": "追踪神秘信号", "type": "main"}]}'::jsonb,
        '{"starting_location": "星际飞船 - 控制室", "opening_narrative": "你从冷冻休眠中醒来，警报声在控制室回荡。舰船AI的声音响起：「检测到未知信号源，距离当前位置3.7光年。」"}'::jsonb
    ),
    (
        '魔法学院',
        'fantasy',
        '欢迎来到艾德拉魔法学院，这里是培养年轻法师的圣地。作为一名新生，你将开启魔法之旅...',
        TRUE,
        '{"system_prompt": "你是一个奇幻魔法世界的AI叙述者。这是一个充满魔法的中世纪风格世界。描述要有魔法氛围和神秘感。", "npcs": [{"key": "master", "name": "大法师沃伦", "personality": "严厉但关心学生"}, {"key": "friend", "name": "学友艾米", "personality": "活泼开朗，好奇心强"}], "quests": [{"key": "first_spell", "title": "学习第一个咒语", "type": "main"}]}'::jsonb,
        '{"starting_location": "学院大门", "opening_narrative": "高耸的尖塔在晨雾中若隐若现，艾德拉魔法学院的大门缓缓打开。你深吸一口气，踏入了这个魔法的殿堂。"}'::jsonb
    ),
    (
        '都市传说',
        'modern',
        '繁华都市的背后，隐藏着不为人知的秘密。作为一名调查记者，你即将揭开惊人的真相...',
        TRUE,
        '{"system_prompt": "你是一个现代都市悬疑故事的AI叙述者。故事发生在一个虚构的现代大都市。营造悬疑和惊悚的氛围。", "npcs": [{"key": "informant", "name": "线人阿杰", "personality": "神秘，话少但可靠"}, {"key": "boss", "name": "主编李华", "personality": "务实，支持正义"}], "quests": [{"key": "investigate", "title": "调查失踪案", "type": "main"}]}'::jsonb,
        '{"starting_location": "报社办公室", "opening_narrative": "桌上的电话突然响起。对面传来一个沙哑的声音：「我有关于失踪案的线索，今晚十点，老地方见。」电话挂断了。"}'::jsonb
    )
ON CONFLICT DO NOTHING;

-- =====================================================
-- GRANT PERMISSIONS (Important for Supabase)
-- =====================================================
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;
