OUTPUT_DIR=build
TARGET=$(OUTPUT_DIR)/hs-commit-msg
SOURCES=Main.hs

default: clean build

build:
	mkdir $(OUTPUT_DIR) 
	ghc -outputdir $(OUTPUT_DIR) -o $(TARGET) $(SOURCES)

clean:
	rm -rf $(OUTPUT_DIR)
