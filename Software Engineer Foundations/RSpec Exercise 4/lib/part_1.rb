def my_reject(array, &prc)
    array.select {|ele| ele if !prc.call(ele)}
end

def my_one?(array, &prc)
    array.count(&prc) == 1
end

def hash_select(hash, &prc)
    hash.each  {|k, v| hash.delete(k) if !prc.call(k, v)}
    hash
end

def xor_select(array, prc_1, prc_2)
    array.select {|ele| ele if prc_1.call(ele) && !prc_2.call(ele) || !prc_1.call(ele) && prc_2.call(ele)}
end

def proc_count(value, array)
    array.count {|prcs| prcs.call(value)}
end

