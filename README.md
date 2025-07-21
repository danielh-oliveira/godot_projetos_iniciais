# 🎮 Mini Games 3D para Android (Godot 4.3)

Este repositório contém uma coletânea de **mini jogos 3D feitos com Godot 4.3**, voltados para dispositivos **Android**.
Cada jogo está organizado em sua própria pasta, com o código-fonte completo, cenas, assets e configurações.

## 📁 Estrutura do Repositório

```
/
├── toque-nos-cubos/
├── cubo-corredor/
├── cubinho-aventuras/
├── alvo-cubico/
└── blocos-do-santuario/
```

---

## 🫒 1. Toque nos Cubos

**Tipo:** Jogo de reflexo / tempo
**Descrição:** Toque nos cubos que aparecem na tela antes que desapareçam.

**Técnicas aprendidas:**

* `InputEventScreenTouch`
* `RayCast3D` a partir da posição do toque
* Instanciar e destruir objetos
* UI com pontuação

**Controles:** Tap (toque simples)
**Complexidade:** 🟢 Muito fácil

---

## 🏃 2. Cubo Corredor

**Tipo:** Endless Runner 3D (estilo Subway Surfers)
**Descrição:** Deslize o dedo para desviar de obstáculos enquanto corre.

**Técnicas aprendidas:**

* `CharacterBody3D` com `move_and_slide`
* Deteccão de gestos (swipe)
* Obstáculos com colisão
* Sistema de pontuação por distância

**Controles:** Swipe (arrastar dedo)
**Complexidade:** 🟡 Fácil

---

## 🧷 3. Cubinho Aventuras

**Tipo:** Plataforma com botões de toque
**Descrição:** Use botões na tela para mover o personagem, pular e coletar cristais.

**Técnicas aprendidas:**

* `TouchScreenButton` e `Button`
* Controle de personagem 3D com pulo
* Coletáveis
* Checkpoint e reinício da fase

**Controles:** Botões na tela
**Complexidade:** 🟠 Média

---

## 🔫 4. Alvo Cúbico

**Tipo:** Aim & Shoot casual
**Descrição:** Mire com o dedo e o personagem atira automaticamente nos inimigos.

**Técnicas aprendidas:**

* Mira com `InputEventScreenDrag`
* `RayCast` para mirar
* Projéteis instanciados
* Sistema de inimigos com spawn e vida

**Controles:** Drag para mirar
**Complexidade:** 🔴 Média/Avançada

---

## 🧠 5. Blocos do Santuário

**Tipo:** Puzzle com física (Sokoban 3D)
**Descrição:** Empurre blocos para resolver puzzles e ativar mecanismos.

**Técnicas aprendidas:**

* `RigidBody3D` com empurrão por toque
* `Area3D` e sinais de interação
* Lógica de puzzle com múltiplos estados
* Finalização de fase ao resolver o enigma

**Controles:** Toque + botão de ação
**Complexidade:** 🔥 Difícil

---

## 📊 Comparativo Geral

| Nº | Nome do Jogo        | Controles       | Técnicas Principais           | Complexidade  |
| -- | ------------------- | --------------- | ----------------------------- | ------------- |
| 1  | Toque nos Cubos     | Tap             | RayCast, UI, Input            | 🟢 Iniciante  |
| 2  | Cubo Corredor       | Swipe           | Movimento, colisão, pontuação | 🟡 Fácil      |
| 3  | Cubinho Aventuras   | Botões na tela  | Pulo, coleta, checkpoints     | 🟠 Médio      |
| 4  | Alvo Cúbico         | Drag para mirar | Mira, projéteis, inimigos     | 🔴 Avançado   |
| 5  | Blocos do Santuário | Toque + botões  | Física, lógica de puzzles     | 🔥 Desafiador |

---

## 🛠️ Requisitos

* **Godot 4.3** (ou superior)
* Plataforma Android para testes

---

## 📅 Como usar

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/nome-do-repositorio.git
   ```

2. Abra o projeto desejado no Godot:

   * Cada pasta contém um mini jogo individual

3. Exporte para Android ou teste no emulador.

---

## 📌 Objetivo do Projeto

Este repositório é uma forma de praticar e compartilhar mini jogos 3D para Android usando a engine **Godot**, explorando diferentes tipos de controles e mecânicas interativas.

---
