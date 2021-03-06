# environment variable
export LANG=ja_JP.UTF-8
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
export PATH="/opt/local/android-sdk-macosx/tools:/opt/subversion/lib:$HOME/.rbenv/bin:/usr/local/bin:$PATH"
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init - zsh)"

# Go install from homebrew
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOROOT/bin:$PATH

#git
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

#alias
alias ls='gls --color=auto'
alias ll='ls -al'
alias cd-ghq='cd $(ghq list --full-path | percol)'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
alias g=git
alias gl='git log -n 20 --pretty=format:"%C(yellow)%h:%C(green)%an:%Creset%s:%C(red)%d"'
alias gs='git status --short --branch'
alias gst='git stash'
alias gsp='git stash pop'
alias vc='scutil --nc start'
alias vd='scutil --nc stop'
alias gc='git branch -a |percol|xargs git chechout'



# for z.sh
source /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# zsh settings,

# vcs_infoロード    
autoload -Uz vcs_info    
# # PROMPT変数内で変数参照する    
setopt prompt_subst    
#
# # vcsの表示    
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'    
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'    
# プロンプト表示直前にvcs_info呼び出し    
precmd() { vcs_info }    



## 補完
autoload -U compinit ; compinit

###  補完候補の大文字小文字の違いを無視
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1 # 補完候補を←↓↑→で選択
zstyle ':completion:*' use-cache true        # 補完キャッシュ

###  kill で 'ps x' のリストから選択可能
zstyle ':completion:*:processes' command 'ps x'

### 補完候補にも色
zstyle ':completion:*' list-colors ${(s. :.)LS_COLORS}
### kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

setopt list_packed           # コンパクトに補完リストを表示
setopt nonomatch             # zsh: no matches found:

unsetopt auto_remove_slash
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete       # 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
                        # 最初にマッチしたものをいきなり挿入、はしない
setopt auto_list             # ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_resume           # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム



# 履歴
autoload -U predict-on       # 履歴による予測入力 (man zshcontrib)
zle -N predict-on
bindkey '^xp'  predict-on    # Cttl+x p で予測オン
bindkey '^x^p' predict-off   # Cttl+x Ctrl+p で予測オフ

## コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## 履歴ファイル
HISTFILE=$HOME/.zsh_history  # 履歴をファイルに保存する
HISTSIZE=100000              # メモリ内の履歴の数
SAVEHIST=100000              # 保存される履歴の数
setopt extended_history      # 履歴ファイルに開始時刻と経過時間を記録
#unsetopt extended_history
setopt append_history        # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt share_history         # 履歴の共有
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除
                        # (→ 先頭にスペースを入れておけば、ヒストリに保存されない)
unsetopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_save_no_dups     # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_expand           # 補完時にヒストリを自動的に展開
setopt hist_find_no_dups

# プロンプト
autoload -U colors     ; colors
# プロンプトテーマを表示するコマンド
# prompt -l
# 基本のプロンプト
PROMPT="%{$reset_color%}$ "
# [場所] プロンプト
PROMPT="%{$reset_color%}[%{$fg[red]%}%B%~%b%{$reset_color%}]$PROMPT"
# 名前@マシン名 プロンプト
PROMPT="%{$reset_color%}%{$fg[green]%}$USER%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}$PROMPT"
PROMPT='[${vcs_info_msg_0_}]:%~/%f '
RPROMPT="%{$fg[green]%}[%*]%{$reset_color%}"



# other options
setopt auto_cd               # ディレクトリのみで移動
setopt auto_pushd            # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups     # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home         # pushd 引数ナシ == pushd $HOME
setopt pushd_silent          # pushd,popdの度にディレクトリスタックの中身を表示しない
# pop command
alias pd='popd'
alias gd='dirs -v; echo -n "select number: ";
read newdir; cd +"$newdir" '


#setopt AUTOLOGOUT=n          # n分後に自動的にログアウト
setopt no_beep               # コマンド入力エラーでBeepを鳴らさない
#setopt beep

setopt complete_in_word
setopt extended_glob         # 拡張グロブを有効にする
setopt brace_ccl             # ブレース展開機能を有効にする
setopt equals                # =COMMAND を COMMAND のパス名に展開
setopt numeric_glob_sort     # 数字を数値と解釈してソートする
setopt path_dirs             # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit       # 補完候補リストの日本語を適正表示
setopt auto_name_dirs
unsetopt flow_control        # (shell editor 内で) C-s, C-q を無効にする
setopt no_flow_control       # C-s/C-q によるフロー制御を使わない
setopt hash_cmds             # 各コマンドが実行されるときにパスをハッシュに入れる
#setopt ignore_eof            # C-dでログアウトしない
setopt bsd_echo
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
#setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst     # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
#setopt mail_warning
setopt multios               # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt short_loops           # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる
#setopt sun_keyboard_hack     # SUNキーボードでの頻出 typo ` をカバーする
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt cdable_vars sh_word_split
setopt rm_star_wait          # rm * を実行する前に確認
#setopt rm_star_silent        # rm * を実行する前に確認しない
#setopt no_clobber            # リダイレクトで上書きを禁止


# for percol 
function percol_select_history() {
	local tac
	if which tac > /dev/null; then
		tac="tac"
	else
		tac="tail -r"
	fi
	BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
	CURSOR=$#BUFFER             # move cursor
	zle -R -c                   # refresh
}
zle -N percol_select_history
bindkey '^R' percol_select_history

function percol_select_directory() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    local dest=$(_z -r 2>&1 | eval $tac | percol --query "$LBUFFER" | awk '{ print $2 }')
    if [ -n "${dest}" ]; then
        cd ${dest}
    fi
    zle reset-prompt
}
zle -N percol_select_directory
bindkey "^X^J" percol_select_directory


function percol_select_git_branch() {
    BRANCH=$(git branch -a | percol --query "$LBUFFER")
    if [ $? -eq 0 ]; then
       git checkout $BRANCH
       git submodule update --init
    fi
    zle reset-prompt
    zle -R -c
}
zle -N percol_select_git_branch
bindkey '^G' percol_select_git_branch


function pe() {
   pt "$@" . | peco --exec 'awk -F : '"'"'{print "+" $2 " " $1}'"'"' | xargs less -N '
 }
