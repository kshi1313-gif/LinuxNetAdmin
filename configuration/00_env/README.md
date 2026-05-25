# 00_env

사용자 쉘 환경과 Vim 편집기 설정 예시를 보관하는 디렉토리입니다.

## 파일 구성

| 파일 | 설명 |
| --- | --- |
| `bashrc.txt` | `$HOME/.bashrc`에 적용할 alias, PATH, PS1 프롬프트, 서비스별 이동/로그 확인 alias 예시입니다. |
| `vimrc.txt` | Vim의 탭, 들여쓰기, 줄 번호, 자동 들여쓰기 설정 예시입니다. |

## 주요 설정

`bashrc.txt`에는 다음과 같은 작업 편의 설정이 포함되어 있습니다.

- `PATH`에 `/test` 추가
- `rm`, `cp`, `mv` 안전 alias
- `ls`, `grep`, `df`, `ps` 관련 alias
- firewall, DNS, FTP, SMB, WEB, MAIL 설정 파일과 로그 파일로 빠르게 이동하는 alias
- 색상이 포함된 `PS1` 프롬프트

`vimrc.txt`에는 다음 설정이 포함되어 있습니다.

```vim
set ts=4
set sw=4
set nu
set ai
```

## 적용 예시

```bash
cp bashrc.txt ~/.bashrc
cp vimrc.txt ~/.vimrc
source ~/.bashrc
```

기존 설정을 덮어쓰지 않도록 적용 전에는 `~/.bashrc`, `~/.vimrc`를 백업하세요.
