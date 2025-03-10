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
OBJS = main.o
LIB_OBJS = hello.o factorial.o test.o  # Добавил test.o в библиотеку

# Компиляция объектных файлов
%.o: %.cpp functions.h
	$(CC) $(CFLAGS) -c $< -o $@

# Создание разделяемой библиотеки (теперь включает тесты)
$(LIBRARY): $(LIB_OBJS)
	$(CC) $(LDFLAGS) -o $(LIBRARY) $(LIB_OBJS)

# Сборка исполняемого файла с разделяемой библиотекой
$(TARGET): main.o $(LIBRARY)
	$(CC) main.o -o $(TARGET) -L. -lfunctions

# Сборка тестового исполняемого файла (теперь использует библиотеку)
test: $(LIBRARY)
	$(CC) -o test -L. -lfunctions
	LD_LIBRARY_PATH=.:$$LD_LIBRARY_PATH ./test  # Добавляем текущую директорию в поиск библиотек

# Основная цель
all: $(LIBRARY) $(TARGET) test

# Очистка скомпилированных файлов
clean:
	rm -rf $(TARGET) $(LIBRARY) *.o test $(DEB_DIR) $(DEB_DIR).deb

# Создание .deb пакета
deb: all
	mkdir -p $(DEB_DIR)/usr/bin $(DEB_DIR)/usr/lib $(DEB_DIR)/DEBIAN
	cp $(TARGET) $(DEB_DIR)/usr/bin/
	cp test $(DEB_DIR)/usr/bin/  # Добавляем тестовый исполняемый файл
	cp $(LIBRARY) $(DEB_DIR)/usr/lib/
	# Файл управления пакетом
	echo "Package: $(PACKAGE)" > $(DEB_DIR)/DEBIAN/control
	echo "Version: $(VERSION)" >> $(DEB_DIR)/DEBIAN/control
	echo "Architecture: $(ARCH)" >> $(DEB_DIR)/DEBIAN/control
	echo "Maintainer: Er1kjan <evmangur@gmail.com>" >> $(DEB_DIR)/DEBIAN/control
	echo "Description: Factorial calculation program" >> $(DEB_DIR)/DEBIAN/control
	echo "Depends: libstdc++6" >> $(DEB_DIR)/DEBIAN/control
  # postinst и prerm скрипты
	echo '#!/bin/bash' > $(DEB_DIR)/DEBIAN/postinst
	echo 'ldconfig' >> $(DEB_DIR)/DEBIAN/postinst
	chmod 755 $(DEB_DIR)/DEBIAN/postinst
	echo '#!/bin/bash' > $(DEB_DIR)/DEBIAN/prerm
	echo 'ldconfig' >> $(DEB_DIR)/DEBIAN/prerm
	chmod 755 $(DEB_DIR)/DEBIAN/prerm
	# Создание пакета
	dpkg-deb --build $(DEB_DIR)
	mv $(DEB_DIR).deb factorial.deb
