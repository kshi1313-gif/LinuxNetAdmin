# Advenced Scripts

사용자 관리, 파일 전송, 네트워크 점검, 환경 설정, 웹 서비스 실행처럼 실제 관리 작업에 가까운 Bash 스크립트 모음입니다. 디렉토리명은 저장소의 기존 이름인 `Advenced`를 그대로 유지했습니다.

## 주요 파일

| 파일 | 설명 |
| --- | --- |
| `add_dir.sh` | `/test` 아래에 반복문으로 다단계 디렉토리 구조를 생성하고 `tree`로 확인합니다. |
| `calculator_ver2.sh` | 숫자 두 개와 연산자를 입력받아 사칙연산을 수행하는 `case`문 예제입니다. |
| `hosts.sh` | 지정한 IP 대역의 호스트 정보를 `/root/bin/hosts` 형식으로 생성합니다. |
| `add_userlist.sh` | `user1 user1` 형태의 사용자/비밀번호 목록을 `/root/bin/user.list`에 생성합니다. |
| `useradd.sh` | `user.list`를 읽어 여러 사용자를 생성하고 비밀번호를 설정합니다. |
| `userdel.sh` | `user.list`에 있는 사용자를 홈 디렉토리까지 함께 삭제합니다. |
| `user_admin.sh` | 터미널 메뉴로 사용자 추가, 확인, 삭제를 수행합니다. |
| `user_manage_dialog.sh` | `dialog` 기반의 사용자 관리 TUI입니다. 사용자 추가, 조회, 삭제, 로그 확인 기능을 포함합니다. |
| `ping.sh` | 지정한 IP 대역을 ping으로 확인하고 결과를 자리 배치 파일과 함께 출력합니다. |
| `ping1.sh` | 지정한 IP 대역에 대해 간단한 ping 성공/실패 결과를 출력합니다. |
| `check_network.sh` | 내부 게이트웨이, 외부 IP, DNS 이름 확인을 단계별로 점검합니다. |
| `ipconfig2.sh` | `nmcli` 기반으로 호스트명, NIC, IP, 게이트웨이, DNS 정보를 출력합니다. |
| `auto_ftp.sh` | FTP here document를 이용해 로컬 파일을 자동 업로드합니다. |
| `auto_ftp_windows.sh` | Linux에서 Windows FTP 서버로 파일을 업로드합니다. |
| `auto_ftp_windows_dialog.sh` | `dialog` 입력 화면으로 FTP 서버, 계정, 파일 경로를 받아 업로드합니다. |
| `ftp_send.sh` | 여러 대상 IP에 동일한 파일을 FTP로 전송합니다. |
| `auto_telnet.sh` | Telnet 접속 후 사용자명, 비밀번호, 명령을 자동 입력하는 예제입니다. |
| `auto_telnet2.sh` | `server.list`를 읽어 여러 서버의 Telnet 로그인을 `expect`로 테스트합니다. |
| `auto_telnet_ftp.sh` | Telnet 접속 후 백업 명령을 자동 입력하기 위한 실험용 스크립트입니다. |
| `move_filename.sh` | `/test`의 `.txt` 파일을 `.els` 확장자로 변경합니다. |
| `move_filename.2.sh` | 지정한 디렉토리에서 `.els` 파일을 `.txt`로 변경합니다. |
| `move_filename3.sh` | 디렉토리와 변경 전/후 확장자를 인자로 받아 재귀적으로 파일명을 변경합니다. |
| `ENV1.sh` | Apache HTTPD와 SSL 관련 패키지 설치, 테스트 index 파일 생성, 서비스 기동을 수행합니다. |
| `ENV2.sh` | 사용자 `.bashrc`, `.vimrc`에 alias, 프롬프트, vim 설정을 추가합니다. |
| `ENV3.sh` | `gnome-tweaks`, `epel-release`, `boxes`, `cowsay` 같은 부가 패키지를 설치합니다. |
| `ENV_main.sh` | `ENV1.sh`, `ENV2.sh`, `ENV3.sh`를 순서대로 실행합니다. |
| `functions.sh` | 공통 변수와 색상 출력 함수(`print_good`, `print_error`, `print_info`)를 정의합니다. |
| `poweroff.sh` | `server1`, `server2`에 SSH로 접속해 전원 종료를 실행합니다. |
| `poweroff2.sh` | `sshpass`를 사용해 서버 전원 종료를 자동화합니다. |
| `webserver.sh` | Apache HTTPD 또는 Nginx 중 하나를 선택해 설치, 기동, 테스트 페이지 생성, 상태 확인을 수행합니다. |

## 실행 전 확인

- 사용자 관리 스크립트는 실제 계정을 생성하거나 삭제합니다.
- FTP/Telnet 스크립트에는 실습용 IP, 계정, 비밀번호가 들어 있으므로 실행 전에 환경에 맞게 수정하세요.
- `poweroff.sh`, `poweroff2.sh`는 원격 서버를 종료합니다. 테스트 환경에서만 신중하게 실행하세요.
- `webserver.sh`, `ENV*.sh`는 패키지 설치와 서비스 상태 변경을 수행하므로 `root` 권한이 필요합니다.

## 예시

```bash
sudo ./useradd.sh
./check_network.sh
sudo ./webserver.sh httpd
sudo ./webserver.sh status
```
