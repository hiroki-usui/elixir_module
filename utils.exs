defmodule Utils do

    # 2倍する
    def double(v) do
        #IO.puts("called double.")
        v * 2
    end

    # 3倍する
    def triple(v) do
        v * 3
    end

    # 4倍する
    def quadruple(v) do
        double(v) + double(v)
    end

    # 階乗を計算する（パターンマッチを使用する）
    def factorial(0) do
        1
    end

    # when（ガード節）を使用して、プラスの値のみ処理する
    def factorial(v) when v > 0 do
        v * factorial(v-1)
    end

    # マイナスの値
    def factorial(_) do
        :ng
    end

    # 1からnまでの合計を計算する（パターンマッチを使用する）
    def sum_stp(0) do
        0
    end
    def sum_stp(v) do
        v + sum_stp(v-1)
    end

    #　最大公約数を計算する
    #  前提として、x , yは正の整数
    def gcd(x, 0) do
        x
    end

    def gcd(x, y) do
        gcd(y, rem(x, y))
    end

    # vの値を抽出する
    # 範囲外
    def guess(v, min_v..max_v) when (v < min_v or v > max_v)  do
        :over_range
    end

    def guess(v, min_v..max_v) do
        guess_search(v, min_v, max_v, max_v)
    end

    defp guess_search(v, min_v, max_v, estimate_v) when max_v <= estimate_v do
        new_estimate_v = div(estimate_v, 2)
        IO.puts "Is it #{new_estimate_v}"
        guess_search(v, min_v, max_v, new_estimate_v) 
    end

    defp guess_search(v, min_v, max_v, estimate_v) when min_v >= estimate_v do
        new_estimate_v = estimate_v + div(estimate_v, 2)
        IO.puts "Is it #{new_estimate_v}"
        guess_search(v, min_v, max_v, new_estimate_v) 
    end

    defp guess_search(estimate_v, min_v, max_v, estimate_v) do
        estimate_v
    end

    # パラメータのリストに値を加算していく
    def add_v_for_list([], _v) do
        []
    end

    def add_v_for_list([h | t], v) do
        [h+v | add_v_for_list(t, v)]
    end

    # 独自のmap
    def map_my([], _f) do
        []
    end

    def map_my([h|t], f) do
        [f.(h) | map_my(t, f)]
    end

    # 合計を計算
    def sum_my(list), do: _sum_my(list, 0)

    defp _sum_my([], _total), do: 0
    defp _sum_my([h | t], total), do: _sum_my(t, total + h)

    # 合計を計算
    # アキュムレータを使用しない
    def sum_my_02([]),  do: 0
    def sum_my_02([h | t]),  do: h + sum_my_02(t)

    # リストの各要素に関数を適用し、その結果を合計する
    def mapsum(l, f), do: _mapsum(l, f, 0)

    defp _mapsum([], _f, total), do: total
    defp _mapsum([h | t], f, total), do: _mapsum(t, f, f.(h) + total)

    # リストの最大値を返す
    def search_max([]), do: :empty_list
    def search_max([h | t]), do: _search_max(t, h)

    defp _search_max([], max_v), do: max_v
    defp _search_max([h | t], max_v) when h > max_v do
        _search_max(t, h)
    end
    defp _search_max([_h | t], max_v), do: _search_max(t, max_v)

    # 文字の暗号化を行う（小文字のみ）
    def caesar([], _add_val), do: []
    def caesar(data_list,add_val) when add_val > 26 do
        caesar(data_list,add_val-26)
    end 
    def caesar([h | t], add_val), do: [conv_char_code(h, add_val) | caesar(t, add_val)]

    # 文字コードの変換を行う
    defp conv_char_code(char_code, add_val) when (char_code + add_val) > 122 do
        char_code + add_val - 26
    end
    defp conv_char_code(char_code, add_val), do: char_code + add_val

    # FromからToまでの数のリストを返す
    def span(from, to) when from > to do
        :bad_parameter
    end

    def span(to, to), do: [to | []]

    def span(from, to), do: [from | span(from + 1, to)]

    # 独自のALLを実装する
    def my_all?([], _f), do: true
    
    def my_all?([v | t], f) do
        if f.(v) do
            my_all?(t, f)
        else
            false
        end
    end

    # 独自のfilterを実装する
    def my_filter([],_f), do: []

    def my_filter([h | t], f) do
            if f.(h) do
                [h | my_filter(t, f)]
            else
                my_filter(t, f)
            end
    end

    # 独自のtakeを実装する
    def my_take([], _v), do: []

    def my_take(_list, 0), do: []

    def my_take([h | t], v), do: [h | my_take(t, v-1)]

    # 独自のsplitを実装する
    def my_split(list, v), do: _my_split(list, v, [])

    defp _my_split([], _v, forward_list), do: {Enum.reverse(forward_list), []}

    defp _my_split(backward_list, 0, forward_list), do: {Enum.reverse(forward_list), backward_list}

    defp _my_split([h | t], v, forward_list), do: _my_split(t , v-1, [h | forward_list])

end

# 個人情報（詳細)
defmodule PersonDetail do
    # 構造体を定義
    defstruct address: "", tel: ""
end

# 個人情報（基本)
defmodule PersonBase do
    # 構造体を定義
    defstruct id: "", name: "", age: -1, detail: %PersonDetail{}
end
