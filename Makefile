CC = cc
LD = cc
REAL_CFLAGS = -I./include $(shell pkg-config --cflags dri gbm libdrm glesv2 egl) -DBUILD_ELM327PLUGIN $(CFLAGS)
REAL_LDFLAGS = $(shell pkg-config --libs dri gbm libdrm glesv2 egl) -lrt -lflutter_engine -lpthread -ldl $(LDFLAGS)

SOURCES = src/flutter-pi.c src/platformchannel.c src/pluginregistry.c src/plugins/elm327plugin.c src/plugins/services-plugin.c src/plugins/testplugin.c
OBJECTS = $(patsubst src/%.c,out/obj/%.o,$(SOURCES))

all: out/flutter-pi

out/obj/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) -c $(REAL_CFLAGS) $(REAL_LDFLAGS) $< -o $@

out/flutter-pi: $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $(REAL_CFLAGS) $(REAL_LDFLAGS) $(OBJECTS) -o out/flutter-pi

clean:
	@mkdir -p out
	rm -rf $(OBJECTS) out/flutter-pi out/obj/*