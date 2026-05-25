# Essential Scripts

Bash 기본 문법과 Linux 관리 명령을 연습하기 위한 예제 스크립트입니다. 조건문, 반복문, `case`, 파일 검사, 표준 입출력, 간단한 서비스 제어 흐름을 확인할 수 있습니다.

## 파일 목록

| 파일 | 설명 |
| --- | --- |
| `echo.sh` | `echo`, `date` 출력 형식을 확인하는 기본 예제입니다. |
| `read.sh` | 사용자 입력을 받아 변수에 저장하고 출력합니다. |
| `enter.sh` | here document와 `read`를 이용해 안내 문구를 출력하고 입력을 기다립니다. |
| `dir.sh` | 입력받은 경로가 일반 파일인지 디렉토리인지 확인합니다. |
| `execfile.sh` | 실행 권한이 있는 파일을 입력받아 실행합니다. |
| `filesize.sh` | 파일 크기를 확인해 기준 크기 이상인지 판단합니다. |
| `findstring.sh` | 파일 안에서 지정한 문자열 패턴을 검색합니다. |
| `chklog.sh` | 로그 파일에서 경고, 실패, 오류 패턴을 주기적으로 확인하고 변경분을 메일로 보냅니다. |
| `cat_file.sh` | `/etc/vsftpd/ftpusers` 목록을 읽어 FTP 접근 거부 사용자를 출력합니다. |
| `count.sh` | `for` 반복문과 `seq` 사용 예제입니다. |
| `tools.sh` | `case`문으로 `who`, `date`, `cal` 중 선택한 명령을 실행합니다. |
| `yes.sh` | yes/no 입력을 다양한 대소문자 패턴으로 처리합니다. |
| `svc` | `systemctl`로 서비스를 시작, 활성화, 중지, 비활성화하고 상태를 확인합니다. |
| `ftp.sh` | 간단한 FTP 프롬프트 형태의 명령 처리 예제입니다. |
| `IO.sh` | here document를 이용해 여러 호스트에 SSH로 명령을 전달하는 예제입니다. |

## 실행 예시

```bash
chmod +x tools.sh
./tools.sh

chmod +x svc
sudo ./svc start sshd
sudo ./svc stop sshd
```

## 학습 포인트

- `if`, `case`, `for`, `while` 구문
- 명령 실행 결과 `$?` 검사
- 파일 테스트 옵션 `-f`, `-d`, `-x`, `-s`
- here document와 파이프를 활용한 자동 입력
