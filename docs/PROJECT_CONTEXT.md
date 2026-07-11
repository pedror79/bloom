# Bloom — Project Context

## Projeto

Bloom é uma aplicação Flutter focada exclusivamente em ajudar pessoas a atingir a Independência Financeira.

A filosofia da Bloom é ser conservadora nas projeções, transparente nos cálculos e simples de utilizar.

---

## Stack

- Flutter
- Dart
- Material 3
- Git
- GitHub

---

## Estado do Projeto

### Sprint 0.1
- Arquitetura inicial
- Design System
- Onboarding
- Dashboard
- Componentes reutilizáveis

### Sprint 0.2
- Bloom Engine Foundation
- FinancialConstants
- BloomUser
- Identity
- FinancialProfile
- ProjectionResult
- UserProfileMapper

### Sprint 0.3
- ProjectionEngine
- PortfolioProjector
- Cálculo de inflação
- FIRE Number
- Validação do plano financeiro
- 19 testes automáticos (todos verdes)

---

## Estrutura Principal

lib/
    core/
        engine/
            projection_engine.dart
            calculators/
                portfolio_projector.dart
        models/
            bloom_user.dart
            identity.dart
            financial_profile.dart
            projection_result.dart

---

## Decisões de Produto

### Financial Independence

A Bloom trabalha simultaneamente com dois objetivos:

- Idade da Independência Financeira
- Rendimento mensal desejado (em euros de hoje)

O rendimento é sempre atualizado para inflação antes dos restantes cálculos.

---

### Filosofia Financeira

A Bloom utiliza sempre projeções conservadoras.

O investimento mensal entra no fim de cada mês.

Nunca são apresentadas projeções excessivamente otimistas.

---

## Estado Atual

Tudo compilável.

Todos os testes verdes.

Último commit:

Sprint 0.3C - Portfolio Projection Engine

---

## Próxima Sprint

Sprint 0.4

Objetivo:

Criar

ProjectionEngine.calculate(BloomUser user)

que deverá:

- validar o plano
- calcular anos até ao objetivo
- projetar património
- calcular FIRE Number
- comparar património necessário vs património projetado
- gerar ProjectionResult
- alimentar o Dashboard automaticamente