mutable struct Rectangle
    x::Int
    y::Int
    width::Int
    height::Int
end

function check_collision_rect(rect1::Rectangle, rect2::Rectangle)
    if rect1.x < rect2.x + rect2.width && 
        rect1.x + rect1.width > rect2.x && 
        rect1.y < rect2.y + rect2.height && 
        rect1.y + rect1.height > rect2.y
         return true
     else
         return false
     end
end