# Claude Code Shell Completion

🇺🇸 [English version](README.md)

[Claude Code](https://claude.com/claude-code) 用のシェル補完スクリプトです。bash、zsh、[Nushell](https://www.nushell.sh/) で、コマンド、サブコマンド、オプションのタブ補完を提供します。

## 機能

- **コマンド補完**: `claude` のサブコマンドをタブ補完 (`agents`, `auto-mode`, `auth`, `mcp`, `plugin`, `plugins`, `setup-token`, `doctor`, `update`, `upgrade`, `install`)
- **オプション補完**: すべての CLI オプションとフラグを補完可能
- **コンテキストに応じた候補表示**: 該当する場合、オプションの値を候補として表示
  - 出力フォーマット: `text`, `json`, `stream-json`
  - パーミッションモード: `acceptEdits`, `bypassPermissions`, `default`, `dontAsk`, `plan`, `auto`
  - モデル: `sonnet`, `opus`, `haiku` など
  - 設定ソース: `user`, `project`, `local`
  - エフォートレベル: `low`, `medium`, `high`, `max`
- **ファイルパス補完**: ファイルパスを受け取るオプション (`--settings`, `--mcp-config`, `--add-dir`, `--file`, `--debug-file` など)
- **サブコマンド補完**: `mcp` と `plugin` コマンドの完全なサブコマンドツリー

## クイックスタート

```bash
git clone https://github.com/hmmf022/cc-completion.git
cd cc-completion
```

### Bash

```bash
mkdir -p ~/.local/share/bash-completion/completions
ln -sf "$(pwd)/claude-completion.bash" ~/.local/share/bash-completion/completions/claude
source ~/.local/share/bash-completion/completions/claude
```

### Zsh

```bash
sudo ln -sf "$(pwd)/_claude" /usr/local/share/zsh/site-functions/_claude
autoload -Uz compinit && compinit
```

### Nushell

Nushell の設定ファイル (`$nu.config-path`) に以下を追加してください:
```nu
use /path/to/cc-completion/claude-completions.nu *
```

> 他のインストール方法 (oh-my-zsh、システム全体への bash インストールなど) は、下記の[インストール詳細](#インストール詳細)を参照してください。

<details>
<summary><h2>インストール詳細</h2></summary>

### Bash

#### 方法 1: システム全体へのインストール

**オプション A: コピー (シンプル)**
```bash
sudo cp claude-completion.bash /etc/bash_completion.d/claude
```
> 注意: リポジトリを更新した場合 (`git pull` など)、再度ファイルをコピーする必要があります。

**オプション B: シンボリックリンク (推奨)**
```bash
sudo ln -sf "$(pwd)/claude-completion.bash" /etc/bash_completion.d/claude
```
> 注意: `git pull` で自動的に更新が反映されます。クローンしたリポジトリを削除・移動しないでください。

その後、シェルを再起動するか以下を実行してください:
```bash
source /etc/bash_completion.d/claude
```

#### 方法 2: ユーザーレベルのインストール

```bash
mkdir -p ~/.local/share/bash-completion/completions
```

**オプション A: コピー (シンプル)**
```bash
cp claude-completion.bash ~/.local/share/bash-completion/completions/claude
```
> 注意: リポジトリを更新した場合 (`git pull` など)、再度ファイルをコピーする必要があります。

**オプション B: シンボリックリンク (推奨)**
```bash
ln -sf "$(pwd)/claude-completion.bash" ~/.local/share/bash-completion/completions/claude
```
> 注意: `git pull` で自動的に更新が反映されます。クローンしたリポジトリを削除・移動しないでください。

`~/.bashrc` に以下を追加してください:
```bash
source ~/.local/share/bash-completion/completions/claude
```

#### 方法 3: 手動で source する

`~/.bashrc` に以下を追加してください:
```bash
source /path/to/claude-completion.bash
```

### Zsh

#### 方法 1: システム全体へのインストール

**オプション A: コピー (シンプル)**
```bash
sudo cp _claude /usr/local/share/zsh/site-functions/_claude
```
> 注意: リポジトリを更新した場合 (`git pull` など)、再度ファイルをコピーする必要があります。

**オプション B: シンボリックリンク (推奨)**
```bash
sudo ln -sf "$(pwd)/_claude" /usr/local/share/zsh/site-functions/_claude
```
> 注意: `git pull` で自動的に更新が反映されます。クローンしたリポジトリを削除・移動しないでください。

その後、補完を再読み込みしてください:
```zsh
rm -f ~/.zcompdump; compinit
```

#### 方法 2: oh-my-zsh を使ったユーザーレベルのインストール

```bash
mkdir -p ~/.oh-my-zsh/custom/plugins/claude
```

**オプション A: コピー (シンプル)**
```bash
cp _claude ~/.oh-my-zsh/custom/plugins/claude/_claude
```
> 注意: リポジトリを更新した場合 (`git pull` など)、再度ファイルをコピーする必要があります。

**オプション B: シンボリックリンク (推奨)**
```bash
ln -sf "$(pwd)/_claude" ~/.oh-my-zsh/custom/plugins/claude/_claude
```
> 注意: `git pull` で自動的に更新が反映されます。クローンしたリポジトリを削除・移動しないでください。

`~/.zshrc` に以下を追加してください:
```zsh
plugins=(... claude)
```

#### 方法 3: 手動で fpath を設定

`~/.zshrc` の `compinit` より前に以下を追加してください:
```zsh
fpath=(/path/to/cc-completion $fpath)
autoload -Uz compinit && compinit
```

### Nushell

Nushell の設定ファイル (`$nu.config-path`) に以下を追加してください:
```nu
use /path/to/cc-completion/claude-completions.nu *
```
> 注意: `/path/to/cc-completion` をクローンしたリポジトリの実際のパスに置き換えてください。

</details>

## 使用例

インストール後、`claude` コマンドでタブ補完が使えるようになります:

```bash
# サブコマンドの補完
claude <TAB>
# 表示: agents auto-mode auth mcp plugin plugins setup-token doctor update upgrade install

# オプションの補完
claude --<TAB>
# 表示: --debug --verbose --print --model --help ...

# オプション値の補完
claude --output-format <TAB>
# 表示: text json stream-json

claude --permission-mode <TAB>
# 表示: acceptEdits bypassPermissions default dontAsk plan auto

claude --model <TAB>
# 表示: sonnet opus haiku best sonnet1m

claude --effort <TAB>
# 表示: low medium high xhigh max

# install のターゲット補完
claude install <TAB>
# 表示: stable latest --force --help

# auth サブコマンドの補完
claude auth <TAB>
# 表示: login logout status

# auth login オプションの補完
claude auth login --<TAB>
# 表示: --claudeai --console --email --sso --help

# auth status オプションの補完
claude auth status --<TAB>
# 表示: --json --text --help

# mcp サブコマンドの補完
claude mcp <TAB>
# 表示: add add-from-claude-desktop add-json get list remove reset-project-choices serve

# mcp add オプションの補完
claude mcp add --transport <TAB>
# 表示: stdio sse http

# plugin サブコマンドの補完
claude plugin <TAB>
# 表示: disable enable install list marketplace uninstall update validate

# ファイルパスの補完
claude --settings <TAB>
# ファイルとディレクトリを表示
```

## 対応コマンド

- `agents` - 設定済みのエージェントを一覧表示 (`--setting-sources` オプション付き)
- `auto-mode` - 自動モード分類器の設定を確認
  - `config` - 自動モード分類器の設定を表示
  - `critique` - 会話に対して自動モードの批評を実行 (`--model` オプション付き)
  - `defaults` - 自動モード分類器のデフォルト設定を表示
- `auth` - 認証の管理
  - `login` - Anthropic アカウントにサインイン (`--claudeai`, `--console`, `--email`, `--sso` オプション付き)
  - `logout` - Anthropic アカウントからログアウト
  - `status` - 現在の認証状態を表示 (`--json`, `--text` オプション付き)
- `mcp` - MCP サーバーの設定・管理
  - `add` - MCP サーバーを追加 (`--scope`, `--transport`, `--env`, `--header`, `--callback-port`, `--client-id`, `--client-secret` オプション付き)
  - `add-from-claude-desktop` - Claude Desktop から MCP サーバーをインポート (`--scope` オプション付き)
  - `add-json` - JSON 文字列で MCP サーバーを追加
  - `get` - MCP サーバーの詳細を取得
  - `list` - 設定済みの MCP サーバーを一覧表示
  - `remove` - MCP サーバーを削除 (`--scope` オプション付き)
  - `reset-project-choices` - プロジェクトスコープのサーバーの承認・拒否をすべてリセット
  - `serve` - Claude Code MCP サーバーを起動
- `plugin` - Claude Code プラグインの管理
  - `disable` - 有効なプラグインを無効化
  - `enable` - 無効なプラグインを有効化
  - `install` (`i`) - 利用可能なマーケットプレイスからプラグインをインストール
  - `list` - インストール済みのプラグインを一覧表示
  - `marketplace` - Claude Code マーケットプレイスの管理 (`add`, `list`, `remove` (`rm`), `update`)
  - `uninstall` (`remove`) - インストール済みのプラグインをアンインストール
  - `update` - プラグインを最新バージョンに更新
  - `validate` - プラグインまたはマーケットプレイスのマニフェストを検証
- `setup-token` - 長期認証トークンを設定
- `doctor` - Claude Code 自動アップデーターの健全性をチェック
- `update` - アップデートを確認し、利用可能な場合はインストール
- `plugins` - `plugin` のエイリアス
- `upgrade` - `update` のエイリアス
- `install` - Claude Code ネイティブビルドをインストール (`--force` オプション付き)

## 対応オプション

すべての Claude Code CLI オプションに対応しています:

- セッション管理: `--continue`, `--resume`, `--fork-session`, `--from-pr`
- モデル選択: `--model`, `--fallback-model`
- 出力制御: `--print`, `--output-format`, `--input-format`
- パーミッション: `--permission-mode`, `--dangerously-skip-permissions`
- ツール: `--tools`, `--allowed-tools`, `--disallowed-tools`
- MCP: `--mcp-config`, `--strict-mcp-config`
- ファイルリソース: `--file`
- ワークツリー: `--worktree`, `--tmux`
- デバッグ: `--debug`, `--debug-file`
- その他多数...

## テスト

インストールを確認するには:

```bash
# bash の場合
type _claude_completion

# zsh の場合
which _claude
```

Nushell の場合、補完が読み込まれていることを確認してください:
```nu
# 外部コマンドが登録されているか確認
help commands | where name =~ "claude"
```

タブ補完を試してみてください:
```bash
claude --mod<TAB>
# 以下のように補完されるはずです: claude --model
```

## トラブルシューティング

### Bash の補完が動作しない場合

1. `bash-completion` パッケージがインストールされていることを確認してください:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install bash-completion

   # macOS (Homebrew)
   brew install bash-completion@2
   ```

2. bash-completion がシェルに読み込まれていることを確認してください:
   ```bash
   type _init_completion
   ```

### Zsh の補完が動作しない場合

1. `~/.zshrc` で `compinit` が呼び出されていることを確認してください:
   ```zsh
   autoload -Uz compinit && compinit
   ```

2. 補完キャッシュを再構築してください:
   ```zsh
   rm -f ~/.zcompdump*; compinit
   ```

3. 補完関数が読み込まれていることを確認してください:
   ```zsh
   which _claude
   ```

### Nushell の補完が動作しない場合

1. Nushell 0.80 以降を使用していることを確認してください (`extern` 補完に必要):
   ```nu
   version
   ```

2. 補完が登録されていることを確認してください:
   ```nu
   help commands | where name =~ "claude"
   ```

## コントリビュート

不足しているコマンドやオプションを見つけた場合は、補完スクリプトを更新してください:

- bash の場合: `claude-completion.bash` を編集
- zsh の場合: `_claude` を編集
- Nushell の場合: `claude-completions.nu` を編集

## ライセンス

[MIT](LICENSE)
