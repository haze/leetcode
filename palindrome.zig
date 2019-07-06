const std = @import("std");
const ascii = std.ascii;

pub fn main() !void {
    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();

    var arena = std.heap.ArenaAllocator.init(&direct_allocator.allocator);
    defer arena.deinit();

    var args_it = std.os.args();
    if (args_it.next(&arena.allocator)) |arg| {
        std.debug.warn("{}\n", isPalindrome(try arg));
    } else {
        std.debug.warn("usage: palindrome <input>\n");
    }
}

fn isPalindrome(input: []const u8) bool {
    // create pointers
    var left: usize = 0;
    var right: usize = input.len - 1;
    while (left < right) {
        while (left < right and !(ascii.isAlpha(input[left]) or ascii.isDigit(input[left]))) {
            left += 1;
        }
        while (left < right and !(ascii.isAlpha(input[right]) or ascii.isDigit(input[right]))) {
            right += 1;
        }
        const leftCh = input[left];
        const rightCh = input[right];
        if (ascii.toLower(leftCh) != ascii.toLower(rightCh)) {
            return false;
        }
        left += 1;
        right -= 1;
    }
    return true;
}
