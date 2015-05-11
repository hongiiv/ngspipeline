# ngspipeline

bcbio의 파이프라인을 Docker를 이용하여 수행하는데 필요한 파일

## prepare.sh
리눅스 서버에 Docker를 설치하고 파이프라인 구동에 필요한 genome reference 파일과 galaxy 설정 파일을 다운로드 한다.
Docker 수행시 로컬의 /bio 폴더를 컨테이너의 /bio 폴더에 매핑한다.

## getdata.sh
/bio 폴더의 genomes, galaxy 폴더를 파이프라인의 /usr/local/share/bcbio에 심볼릭 링크를 생성하고, /bio 폴더에 workflow-날짜 형식의 작업 디렉토리를 설정한 후 엑솜데이터를 다운로드하여 파이프라인을 실행한다. 
