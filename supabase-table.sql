-- ============================================================
-- Table d'inscriptions : Dialogue citoyen Soupetard
-- À exécuter dans l'éditeur SQL de Supabase
-- https://dyaiezuuxdfkjdfpilji.supabase.co
-- ============================================================

CREATE TABLE IF NOT EXISTS inscriptions_soupetard (
  id             uuid         DEFAULT gen_random_uuid() PRIMARY KEY,
  prenom         text         NOT NULL,
  nom            text         NOT NULL,
  email          text         NOT NULL UNIQUE,
  telephone      text,
  consent_rappel boolean      NOT NULL DEFAULT false,
  consent_suite  boolean      NOT NULL DEFAULT false,
  created_at     timestamptz  DEFAULT now()
);

-- Activer Row Level Security
ALTER TABLE inscriptions_soupetard ENABLE ROW LEVEL SECURITY;

-- Permettre l'inscription publique (visiteurs anonymes)
-- Condition : consent_rappel doit être true (case obligatoire cochée)
CREATE POLICY "inscription_publique" ON inscriptions_soupetard
  FOR INSERT TO anon
  WITH CHECK (consent_rappel = true);

-- Permettre aux utilisateurs authentifiés (admins) de lire toutes les inscriptions
CREATE POLICY "lecture_admin" ON inscriptions_soupetard
  FOR SELECT TO authenticated
  USING (true);
