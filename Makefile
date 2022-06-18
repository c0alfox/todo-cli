INCLUDE_DIR := ./include
OBJ_DIR     := ./obj
SRC_DIR     := ./src
BIN_DIR     := ./bin

CXX       := clang++
CXXFLAGS  := -Wall -Werror -pedantic -I $(INCLUDE_DIR)

TARGET := $(BIN_DIR)/main
DEBUG  := $(BIN_DIR)/debug

_DEPS :=
DEPS  := $(patsubst %,$(INCLUDE_DIR)/%,$(_DEPS))

_OBJ  :=
OBJ   := $(patsubst %,$(OBJ_DIR)/%,$(_OBJ))

$(OBJ_DIR)/%.o: $(INCLUDE_DIR)/%.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CXXFLAGS)

$(TARGET): $(OBJ) $(SRC_DIR)/main.cpp
	$(CXX) -o $@ $^ $(CXXFLAGS)

$(DEBUG): $(OBJ) $(SRC_DIR)/main.cpp
	$(CXX) -o $@ $^ $(CXXFLAGS) -g

.PHONY: run debug valgrind clean

run: $(TARGET)
	$(BIN_DIR)/main

debug: $(DEBUG)
	$(BIN_DIR)/debug

valgrind: $(DEBUG)
	valgrind $(BIN_DIR)/debug

clean:
	rm -f $(BIN_DIR)/* $(OBJ_DIR)/*