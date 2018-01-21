src = $(wildcard ID3v2/source/**/**/*.cpp) \
      $(wildcard ID3v2/source/**/*.cpp) \
      $(wildcard ID3v2/source/*.cpp)
obj = $(src:.cpp=.o)
dep = $(obj:.o=.d)
CXXFLAGS = -O -IID3v2/include

ex: ID3v2-Example/main.cpp $(obj)
	$(CXX) $(CXXFLAGS) -o $@ $^

-include $(dep)

%.d: %.cpp
	$(CXX) $(CXXFLAGS) $< -MM -MT $(@:.d=.o) > $@

.PHONY: clean
clean: ex $(obj) $(dep)
	rm $^

