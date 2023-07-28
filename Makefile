BINARY_NAME=confluence-gardner
 
all: lint build
 
build:
		go build -o ${BINARY_NAME}
 
run:
		go build -o ${BINARY_NAME}
		./${BINARY_NAME}
 
lint:
		gofumpt -w .
clean:
		go clean
		rm ${BINARY_NAME}
