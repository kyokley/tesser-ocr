# Usage
Build:
```
docker build -t tesser-ocr .
```

Run:
```
docker run --rm \
		   -it \
		   -v $(pwd):/code \
		   tesser-ocr \
		   /bin/bash
```
