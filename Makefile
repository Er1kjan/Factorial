# Компилятор
CC = g++
# Флаги компиляции
CFLAGS = -Wall -Wextra -std=c++11 -fPIC
# Флаг для создания разделяемой библиотеки
LDFLAGS = -shared

# Имя исполняемого файла
TARGET = main
# Имя библиотеки
LIBRARY = libfunctions.so
# Имя пакета
PACKAGE = factorialpackage
VERSION = 1.0
ARCH = amd64
DEB_DIR = $(PACKAGE)

# Список объектных файлов
OBJS = main.o hello.o factorial.o
LIB_OBJS = hello.o factorial.o

# Компиляция объектных файлов
main.o: main.cpp functions.h
	$(CC) $(CFLAGS) -c main.cpp

hello.o: hello.cpp functions.h
	$(CC) $(CFLAGS) -c hello.cpp

factorial.o: factorial.cpp functions.h
	$(CC) $(CFLAGS) -c factorial.cpp

# Создание разделяемой библиотеки
$(LIBRARY): $(LIB_OBJS)
	$(CC) $(LDFLAGS) -o $(LIBRARY) $(LIB_OBJS)

# Сборка исполняемого файла с разделяемой библиотекой
$(TARGET): main.o $(LIBRARY)
	$(CC) main.o -o $(TARGET) -L. -lfunctions

# Основная цель
all: $(LIBRARY) $(TARGET)

# Очистка скомпилированных файлов
clean:
	rm -rf $(TARGET) $(LIBRARY) *.o $(DEB_DIR) $(DEB_DIR).deb

# Создание .deb пакета
deb: all
	mkdir -p $(DEB_DIR)/usr/bin $(DEB_DIR)/usr/lib $(DEB_DIR)/DEBIAN
	cp $(TARGET) $(DEB_DIR)/usr/bin/
	cp $(LIBRARY) $(DEB_DIR)/usr/lib/
	echo "Package: $(PACKAGE)" > $(DEB_DIR)/DEBIAN/control
	echo "Version: $(VERSION)" >> $(DEB_DIR)/DEBIAN/control
	echo "Architecture: $(ARCH)" >> $(DEB_DIR)/DEBIAN/control
	echo "Maintainer: Er1kjan <evmangur@gmail.com>" >> $(DEB_DIR)/DEBIAN/control
	echo "Description: Factorial calculation program" >> $(DEB_DIR)/DEBIAN/control
	chmod 755 $(DEB_DIR)/DEBIAN/control
	dpkg-deb --build $(DEB_DIR)
	mv $(DEB_DIR).deb factorial.deb
