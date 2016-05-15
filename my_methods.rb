module Enumerable
    def my_each
        i = 0
        while i < self.size
            yield(self[i])
            i += 1
        end
        self
    end

    def my_each_with_index
        i = 0
        while i < self.size
            yield(self[i], i)
            i += 1
        end
        self
    end

    def my_select
        i = 0
        my_arr = []
        while i < self.size
            my_arr << self[i] if yield(self[i])
            i += 1
        end
        my_arr
    end

    def my_all?
        i = 0
        if block_given?
          while i < self.size
              return false unless yield(self[i])
              i += 1
          end
          true
        else
          self.my_each do |obj|
            return false unless obj
          end
          true
        end
    end

    def my_any?
        i = 0
        if block_given?
          while i < self.size
              return true unless yield(self[i]) == nil || yield(self[i]) == false
              i += 1
          end
          false
        else
          self.my_each do |obj|
            return true if obj
          end
          false
        end
    end

    def my_none?
        i = 0
        while i < self.size
            if block_given? && yield(self[i])
                return false
            elsif !block_given? && self[i]
                return false
            end
            i += 1
        end
        true
    end

    def my_count(options = {})
        result = 0
        if block_given?
            i = 0
            result = 0
            while i < self.size
                result += 1 if yield(self[i])
                i += 1
            end
            return result
        elsif options.is_a?(Integer)
            return options
        else
            count = 0
            self.my_each_with_index {|x, i| count += 1}
            return count
        end
    end

    def my_map(proc = nil)
        my_arr = []
        self.my_each do |i|
          if proc
            my_arr << proc.call(i)
          else
            my_arr << yield(i)
          end
        end
        my_arr
    end

    alias_method :my_collect, :my_map

    def my_inject(input=ARGV)
      params = self.first
      self.my_each_with_index do |i, index|
        unless (index == 0)
          params = yield(params, i)
        end
      end
      params
    end
end
