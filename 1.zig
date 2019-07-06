const std = @import("std");
const dbg = std.debug;
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();

    var arena = std.heap.ArenaAllocator.init(&direct_allocator.allocator);
    defer arena.deinit();
    const input = []u8{ 5, 4, 3, 2, 1 };
    if (try two_sum(&arena.allocator, u8, input, 8)) |solution| {
        print_solution(solution);
    } else {
        dbg.warn("no solution found\n");
    }
}

pub fn print_solution(solution: [2]usize) void {
    dbg.warn("[{}, {}]\n", solution[0], solution[1]);
}

pub fn two_sum(allocator: *Allocator, comptime T: type, data: []const T, target: T) !?[2]usize {
    var map = std.AutoHashMap(T, usize).init(allocator);
    defer map.deinit();
    {
        var index: usize = 0;
        while (index < data.len) : (index += 1) {
            const number = data[index];
            const value = target - number;
            if (map.get(value)) |kv| {
                return [2]usize{ kv.value + 1, index + 1 };
            }
            _ = try map.put(number, index);
        }
    }
    return null;
}
