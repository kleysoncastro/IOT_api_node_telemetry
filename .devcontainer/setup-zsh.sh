#!/bin/bash

set -e

# Instala oh-my-zsh se ainda não estiver instalado
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Instalando oh-my-zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo "Instalando plugins zsh..."

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true
git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search || true

echo "Instalando spaceship-prompt (tema)..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

ZSHRC="$HOME/.zshrc"

echo "Configurando .zshrc..."

# Define o tema spaceship
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/' "$ZSHRC" || echo 'ZSH_THEME="spaceship"' >> "$ZSHRC"

# Plugins
sed -i 's/^plugins=(.*)/plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)/' "$ZSHRC" || \
  echo 'plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)' >> "$ZSHRC"

# Configurações de histórico e comportamento
cat <<'EOF' >> "$ZSHRC"


# 🔧 Configurações do tema spaceship
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  hg
  exec_time
  line_sep
  jobs
  exit_code
  char
  docker_compose
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Melhorias no histórico do zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history
setopt inc_append_history

# Ativa plugins manuais
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
EOF

echo "Zsh com tema Spaceship configurado com sucesso! Reinicie o terminal para aplicar as mudanças."