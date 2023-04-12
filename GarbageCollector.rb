class GarbageCollector
    def initialize
        @objects = []
    end

    def add(object)
        @objects << object
    end

    def collect_garbage
        @objects.dup.each do |object|
            if object.should_delete?
                @objects.delete(object)
                object.destroy if object.respond_to?(:destroy)
                puts "Success."
            end
        end
    end
end

class TestClass
    def initialize(gc)
        gc.add(self)
    end

    def should_delete?
        false
    end

    def destroy
    end
end

gc = GarbageCollector.new

object1 = TestClass.new(gc)
object2 = TestClass.new(gc)
object3 = TestClass.new(gc)

gc.collect_garbage
