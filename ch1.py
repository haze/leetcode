from timeit import default_timer as timer

def twoSum(inp, target):
    reverse_index = {}
    for i, n in enumerate(inp):
        value = target - n
        if value in reverse_index:
            return reverse_index[value] + 1, i + 1
        reverse_index[n] = i

start = timer()
solution = twoSum([5, 4, 3, 2, 1], 8)
end = timer()
print(f'took {end - start} secs')
