# iSCSI

iSCSI 스토리지 실습 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, target 서버와 initiator 클라이언트 구성을 나누어 문서화하면 좋습니다.

## 정리하면 좋은 항목

| 구분 | 내용 |
| --- | --- |
| Target 패키지 | `targetcli` 또는 `targetcli-fb` |
| Initiator 패키지 | `iscsi-initiator-utils` |
| 주요 설정 | IQN, backstore, target portal, ACL |
| 주요 서비스 | `target.service`, `iscsid.service` |
| 방화벽 | TCP 3260 |

## 확인 명령

```bash
targetcli ls
iscsiadm -m discovery -t sendtargets -p <target-ip>
iscsiadm -m node --login
lsblk
```
