CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11

# Имя исполняемого файла
TARGET = main

# Список объектных файлов
OBJS = main.o hello.o factorial.o

# Основная цель по умолчанию
all: $(TARGET)

# Компиляция исполняемого файла
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Компиляция отдельных файлов
main.o: main.cpp functions.h
	$(CXX) $(CXXFLAGS) -c main.cpp

hello.o: hello.cpp functions.h
	$(CXX) $(CXXFLAGS) -c hello.cpp

factorial.o: factorial.cpp functions.h
	$(CXX) $(CXXFLAGS) -c factorial.cpp

# Удаление скомпилированных файлов
clean:
	rm -f $(TARGET) $(OBJS)
