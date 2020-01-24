# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method "//".to_sym do
    "//"
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
class A2
  def initialize(array)
    array.each do |attr|
      define_singleton_method("hoge_#{attr}") do |num|
        return "#{__method__}" * num.to_i unless num.nil?
        dev_team
      end
    end
  end

  def dev_team
    "SmartHR Dev Team"
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(base)
    base.define_singleton_method(:my_attr_accessor) do |var|
      define_method(var) do
        instance_variable_get("@#{var}")
      end

      define_method("#{var}=") do |value|
        instance_variable_set("@#{var}", value)

        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          define_singleton_method("#{var}?") do
            send(var)
          end
        end
      end
    end
  end
end
