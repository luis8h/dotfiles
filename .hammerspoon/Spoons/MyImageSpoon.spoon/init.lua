-- Define the Spoon
local obj = {}
obj.__index = obj

-- The drawing object will be stored here
local myDrawing = nil

function obj:showImage(path)
    print("DEBUG: showImage called with path: " .. path)
    local myImage = hs.image.imageFromPath(path)

    if not myImage then
        print("ERROR: Image loading failed!")
        hs.alert.show("Failed to load image!")
        return
    end

    local screenFrame = hs.screen.primaryScreen():frame()
    local imageSize = 400
    local drawingFrame = {
        x = screenFrame.w/2 - imageSize/2,
        y = screenFrame.h/2 - imageSize/2,
        w = imageSize,
        h = imageSize
    }

    myDrawing = hs.drawing.image(drawingFrame, myImage)

    if myDrawing then
        print("DEBUG: myDrawing object successfully created.")
        myDrawing:show()
    else
        print("ERROR: myDrawing object creation failed!")
        return
    end
end

-- The function that hides the image
function obj:hideImage()
    if myDrawing then
        myDrawing:hide()
    end
end

-- A hotkey to toggle the image display
function obj:bindHotkeys(mapping)
    mapping = mapping or {}
    hs.hotkey.bind(mapping.modifiers or {"ctrl", "shift"}, mapping.key or "i", function()
        if myDrawing and myDrawing:isVisible() then
            self:hideImage()
        else
            self:showImage("/Users/luis8h/Pictures/2024-08-05T08-20-21_code.png")
        end
    end)
end

-- The module's constructor
function obj.init()
    -- This can be used to set up any initial state for the Spoon
end

return obj
