main = $(wildcard ID3v2/source/*.cpp)
src = $(wildcard ID3v2/source/**/**/*.cpp) \
      $(wildcard ID3v2/source/**/*.cpp) \
      $(main)
main_obj = $(src:.cpp=.o)
obj = $(src:.cpp=.o)
dep = $(obj:.o=.d)
CXXFLAGS = -O -IID3v2/include -fPIC

# OSX only?
libID3v2.dylib: $(main_obj)
	$(CXX) -dynamiclib -fPIC -o $@ $^

# Wait, is this for Linux only?
# libID3v2.so: $(main_obj)
# 	$(CXX) -shared -o $@ $^

ID3v2.a: $(main_obj)
	ar rvs $@ $^

-include $(dep)

%.d: %.cpp
	@$(CXX) $(CXXFLAGS) $< -MM -MT $(@:.d=.o) > $@

clean: libID3v2.so ID3v2.a $(obj) $(dep)
	rm $^
