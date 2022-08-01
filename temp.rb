require 'pry-byebug'

module Foo
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def a_class_method
      puts "ClassMethod Inside Module"
    end
  end
 
  def not_a_class_method
    puts "Instance method of foo module"
  end
 end
 
 class FooBar
  include Foo
 end
 
 FooBar.a_class_method
 
 puts FooBar.methods.include?(:a_class_method)
 
 puts FooBar.methods.include?(:not_a_class_method)
 
 fb = FooBar.new
 
 fb.not_a_class_method
 
 puts fb.methods.include?(:not_a_class_method)
 
 puts fb.methods.include?(:a_class_method)
 