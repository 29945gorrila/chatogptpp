-- CONTINUATION OF COHOES ENHANCED UI
-- Add these methods to the Tab object in your main file

-- Enhanced Dropdown with Outline
function Tab:CreateDropdown(options)
    local name = options.Name or "Dropdown"
    local optionsList = options.Options or {}
    local default = options.Default or optionsList[1] or ""
    local callback = options.Callback or function() end
    local parent = options.Section or self.page
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 26)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.45, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(245, 245, 245)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0.55, -4, 0, 22)
    dropBtn.Position = UDim2.new(0.45, 4, 0.5, -11)
    dropBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 35)
    dropBtn.BorderSizePixel = 0
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.Text = default .. " ▼"
    dropBtn.TextColor3 = Color3.fromRGB(86, 86, 87)
    dropBtn.TextSize = 14
    dropBtn.AutoButtonColor = false
    dropBtn.Parent = container
    
    local dropBtnCorner = Instance.new("UICorner")
    dropBtnCorner.CornerRadius = UDim.new(0, 4)
    dropBtnCorner.Parent = dropBtn
    
    -- Dropdown list with outline
    local dropHolder = Instance.new("Frame")
    dropHolder.Size = UDim2.new(0, 0, 0, 0)
    dropHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 29)
    dropHolder.BorderSizePixel = 0
    dropHolder.Visible = false
    dropHolder.ZIndex = 101
    dropHolder.Parent = OverlayContainer
    
    local dropHolderCorner = Instance.new("UICorner")
    dropHolderCorner.CornerRadius = UDim.new(0, 4)
    dropHolderCorner.Parent = dropHolder
    
    -- Outline for dropdown
    local dropOutline = Instance.new("Frame")
    dropOutline.Position = UDim2.new(0, 1, 0, 1)
    dropOutline.Size = UDim2.new(1, -2, 1, -2)
    dropOutline.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    dropOutline.BorderSizePixel = 0
    dropOutline.Parent = dropHolder
    
    local dropOutlineCorner = Instance.new("UICorner")
    dropOutlineCorner.CornerRadius = UDim.new(0, 4)
    dropOutlineCorner.Parent = dropOutline
    
    AddShadow(dropHolder, 0.3)
    
    local dropScroll = Instance.new("ScrollingFrame")
    dropScroll.Size = UDim2.new(1, 0, 1, 0)
    dropScroll.BackgroundTransparency = 1
    dropScroll.BorderSizePixel = 0
    dropScroll.ScrollBarThickness = 2
    dropScroll.ScrollBarImageColor3 = Theme.TextDark
    dropScroll.CanvasSize = UDim2.new(0, 0, 0, #optionsList * 24)
    dropScroll.ZIndex = 102
    dropScroll.Parent = dropOutline
    
    local dropPadding = Instance.new("UIPadding")
    dropPadding.PaddingBottom = UDim.new(0, 6)
    dropPadding.PaddingTop = UDim.new(0, 3)
    dropPadding.PaddingLeft = UDim.new(0, 3)
    dropPadding.Parent = dropScroll
    
    local dropLayout = Instance.new("UIListLayout")
    dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dropLayout.Padding = UDim.new(0, 5)
    dropLayout.Parent = dropScroll
    
    local currentValue = default
    local isOpen = false
    
    local function createOptions()
        for _, child in pairs(dropScroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        for i, option in ipairs(optionsList) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, -12, 0, 24)
            optBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 35)
            optBtn.BackgroundTransparency = 1
            optBtn.BorderSizePixel = 0
            optBtn.Font = Enum.Font.Gotham
            optBtn.Text = option
            optBtn.TextColor3 = Color3.fromRGB(72, 72, 73)
            optBtn.TextSize = 14
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.LayoutOrder = i
            optBtn.ZIndex = 103
            optBtn.Parent = dropScroll
            Cohoes:ApplyTheme(optBtn, "TextColor3")
            
            local optPadding = Instance.new("UIPadding")
            optPadding.PaddingTop = UDim.new(0, 1)
            optPadding.PaddingRight = UDim.new(0, 5)
            optPadding.PaddingLeft = UDim.new(0, 5)
            optPadding.Parent = optBtn
            
            optBtn.MouseEnter:Connect(function()
                Cohoes:tween(optBtn, {BackgroundTransparency = 0}, Enum.EasingStyle.Quad, 0.1)
            end)
            
            optBtn.MouseLeave:Connect(function()
                Cohoes:tween(optBtn, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.1)
            end)
            
            optBtn.MouseButton1Down:Connect(function()
                currentValue = option
                dropBtn.Text = option .. " ▼"
                callback(option)
                task.wait(0.05)
                isOpen = false
                Cohoes:tween(dropHolder, {Size = UDim2.new(0, dropBtn.AbsoluteSize.X, 0, 0)}, Enum.EasingStyle.Quad, 0.2)
                task.wait(0.2)
                dropHolder.Visible = false
            end)
        end
        
        dropScroll.CanvasSize = UDim2.new(0, 0, 0, #optionsList * 24)
    end
    
    createOptions()
    
    local function updateDropPosition()
        local absPos = dropBtn.AbsolutePosition
        local absSize = dropBtn.AbsoluteSize
        dropHolder.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 2)
    end
    
    dropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            updateDropPosition()
            dropHolder.Visible = true
            Cohoes:tween(dropHolder, {Size = UDim2.new(0, dropBtn.AbsoluteSize.X, 0, math.min(#optionsList * 24 + 10, 150))}, Enum.EasingStyle.Quad, 0.2)
        else
            Cohoes:tween(dropHolder, {Size = UDim2.new(0, dropBtn.AbsoluteSize.X, 0, 0)}, Enum.EasingStyle.Quad, 0.2)
            task.wait(0.2)
            dropHolder.Visible = false
        end
    end)
    
    local clickConnection
    clickConnection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
            task.wait()
            if not isOpen then return end
            
            local mousePos = UserInputService:GetMouseLocation()
            local listPos = dropHolder.AbsolutePosition
            local listSize = dropHolder.AbsoluteSize
            local btnPos = dropBtn.AbsolutePosition
            local btnSize = dropBtn.AbsoluteSize
            
            local inList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and
                           mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y
            local inBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and
                          mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
            
            if not inList and not inBtn then
                isOpen = false
                Cohoes:tween(dropHolder, {Size = UDim2.new(0, dropBtn.AbsoluteSize.X, 0, 0)}, Enum.EasingStyle.Quad, 0.2)
                task.wait(0.2)
                dropHolder.Visible = false
            end
        end
    end)
    
    local Dropdown = {}
    function Dropdown:Set(value)
        currentValue = value
        dropBtn.Text = value .. " ▼"
        callback(value)
    end
    function Dropdown:Get() return currentValue end
    function Dropdown:Refresh(newOptions)
        optionsList = newOptions
        createOptions()
    end
    
    return Dropdown
end

-- Enhanced Color Picker (full implementation from Milenium)
function Tab:CreateColorPicker(options)
    local name = options.Name or "Color"
    local default = options.Default or Color3.fromRGB(255, 255, 255)
    local alpha = options.Alpha or 0
    local callback = options.Callback or function() end
    local parent = options.Section or self.page
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 26)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(245, 245, 245)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(0, 16, 0, 16)
    colorBtn.Position = UDim2.new(1, -16, 0.5, -8)
    colorBtn.BackgroundColor3 = default
    colorBtn.BorderSizePixel = 0
    colorBtn.Text = ""
    colorBtn.AutoButtonColor = false
    colorBtn.Parent = container
    
    local colorBtnCorner = Instance.new("UICorner")
    colorBtnCorner.CornerRadius = UDim.new(0, 4)
    colorBtnCorner.Parent = colorBtn
    
    local colorBtnGlow = AddGlow(colorBtn, default, 12, 0.6)
    
    local colorBtnInline = Instance.new("Frame")
    colorBtnInline.Position = UDim2.new(0, 1, 0, 1)
    colorBtnInline.Size = UDim2.new(1, -2, 1, -2)
    colorBtnInline.BackgroundColor3 = default
    colorBtnInline.BorderSizePixel = 0
    colorBtnInline.Parent = colorBtn
    
    local inlineCorner = Instance.new("UICorner")
    inlineCorner.CornerRadius = UDim.new(0, 4)
    inlineCorner.Parent = colorBtnInline
    
    local inlineGradient = Instance.new("UIGradient")
    inlineGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(211, 211, 211)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 211))
    }
    inlineGradient.Parent = colorBtnInline
    
    -- Color picker popup
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 166, 0, 197)
    pickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 29)
    pickerFrame.Visible = false
    pickerFrame.ZIndex = 101
    pickerFrame.BorderSizePixel = 0
    pickerFrame.Parent = OverlayContainer
    
    local pickerCorner = Instance.new("UICorner")
    pickerCorner.CornerRadius = UDim.new(0, 6)
    pickerCorner.Parent = pickerFrame
    
    -- Inline frame
    local pickerInline = Instance.new("Frame")
    pickerInline.Position = UDim2.new(0, 1, 0, 1)
    pickerInline.Size = UDim2.new(1, -2, 1, -2)
    pickerInline.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    pickerInline.BorderSizePixel = 0
    pickerInline.Parent = pickerFrame
    
    local pickerInlineCorner = Instance.new("UICorner")
    pickerInlineCorner.CornerRadius = UDim.new(0, 6)
    pickerInlineCorner.Parent = pickerInline
    
    AddShadow(pickerFrame, 0.3)
    
    -- Saturation/Value picker
    local satHolder = Instance.new("Frame")
    satHolder.Position = UDim2.new(0, 7, 0, 7)
    satHolder.Size = UDim2.new(1, -14, 1, -80)
    satHolder.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
    satHolder.BorderSizePixel = 0
    satHolder.Parent = pickerInline
    
    local satHolderCorner = Instance.new("UICorner")
    satHolderCorner.CornerRadius = UDim.new(0, 4)
    satHolderCorner.Parent = satHolder
    
    local satBtn = Instance.new("TextButton")
    satBtn.Size = UDim2.new(1, 0, 1, 0)
    satBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    satBtn.BorderSizePixel = 0
    satBtn.Text = ""
    satBtn.AutoButtonColor = false
    satBtn.ZIndex = 102
    satBtn.Parent = satHolder
    
    local satCorner = Instance.new("UICorner")
    satCorner.CornerRadius = UDim.new(0, 4)
    satCorner.Parent = satBtn
    
    local satGradient = Instance.new("UIGradient")
    satGradient.Rotation = 270
    satGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    satGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    satGradient.Parent = satBtn
    
    local valFrame = Instance.new("Frame")
    valFrame.Size = UDim2.new(1, 0, 1, 0)
    valFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    valFrame.BorderSizePixel = 0
    valFrame.Parent = satHolder
    
    local valGradient = Instance.new("UIGradient")
    valGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    valGradient.Parent = valFrame
    
    local valCorner = Instance.new("UICorner")
    valCorner.CornerRadius = UDim.new(0, 4)
    valCorner.Parent = valFrame
    
    local satValPicker = Instance.new("TextButton")
    satValPicker.AnchorPoint = Vector2.new(0, 1)
    satValPicker.Position = UDim2.new(1, 0, 0, 0)
    satValPicker.Size = UDim2.new(0, 8, 0, 8)
    satValPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    satValPicker.BorderSizePixel = 0
    satValPicker.Text = ""
    satValPicker.AutoButtonColor = false
    satValPicker.ZIndex = 105
    satValPicker.Parent = satHolder
    
    local satValCorner = Instance.new("UICorner")
    satValCorner.CornerRadius = UDim.new(0, 9999)
    satValCorner.Parent = satValPicker
    
    local satValStroke = Instance.new("UIStroke")
    satValStroke.Color = Color3.fromRGB(255, 255, 255)
    satValStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    satValStroke.Parent = satValPicker
    
    -- Hue gradient
    local hueGradient = Instance.new("TextButton")
    hueGradient.Position = UDim2.new(0, 10, 1, -64)
    hueGradient.Size = UDim2.new(1, -20, 0, 8)
    hueGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueGradient.BorderSizePixel = 0
    hueGradient.Text = ""
    hueGradient.AutoButtonColor = false
    hueGradient.Parent = pickerInline
    
    local hueGradCorner = Instance.new("UICorner")
    hueGradCorner.CornerRadius = UDim.new(0, 6)
    hueGradCorner.Parent = hueGradient
    
    local hueGrad = Instance.new("UIGradient")
    hueGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    hueGrad.Parent = hueGradient
    
    local huePicker = Instance.new("TextButton")
    huePicker.AnchorPoint = Vector2.new(0, 0.5)
    huePicker.Position = UDim2.new(0, 0, 0.5, 0)
    huePicker.Size = UDim2.new(0, 8, 0, 8)
    huePicker.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    huePicker.BorderSizePixel = 0
    huePicker.Text = ""
    huePicker.AutoButtonColor = false
    huePicker.ZIndex = 105
    huePicker.Parent = hueGradient
    
    local huePickerCorner = Instance.new("UICorner")
    huePickerCorner.CornerRadius = UDim.new(0, 9999)
    huePickerCorner.Parent = huePicker
    
    local huePickerStroke = Instance.new("UIStroke")
    huePickerStroke.Color = Color3.fromRGB(255, 255, 255)
    huePickerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    huePickerStroke.Parent = huePicker
    
    -- Alpha gradient
    local alphaGradient = Instance.new("TextButton")
    alphaGradient.Position = UDim2.new(0, 10, 1, -46)
    alphaGradient.Size = UDim2.new(1, -20, 0, 8)
    alphaGradient.BackgroundColor3 = Color3.fromRGB(25, 25, 29)
    alphaGradient.BorderSizePixel = 0
    alphaGradient.Text = ""
    alphaGradient.AutoButtonColor = false
    alphaGradient.Parent = pickerInline
    
    local alphaCorner = Instance.new("UICorner")
    alphaCorner.CornerRadius = UDim.new(0, 6)
    alphaCorner.Parent = alphaGradient
    
    local alphaGrad = Instance.new("UIGradient")
    alphaGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
    alphaGrad.Parent = alphaGradient
    
    local alphaPicker = Instance.new("TextButton")
    alphaPicker.AnchorPoint = Vector2.new(0, 0.5)
    alphaPicker.Position = UDim2.new(1, 0, 0.5, 0)
    alphaPicker.Size = UDim2.new(0, 8, 0, 8)
    alphaPicker.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    alphaPicker.BorderSizePixel = 0
    alphaPicker.Text = ""
    alphaPicker.AutoButtonColor = false
    alphaPicker.ZIndex = 105
    alphaPicker.Parent = alphaGradient
    
    local alphaPickerCorner = Instance.new("UICorner")
    alphaPickerCorner.CornerRadius = UDim.new(0, 9999)
    alphaPickerCorner.Parent = alphaPicker
    
    local alphaPickerStroke = Instance.new("UIStroke")
    alphaPickerStroke.Color = Color3.fromRGB(255, 255, 255)
    alphaPickerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    alphaPickerStroke.Parent = alphaPicker
    
    -- Alpha indicator (checkerboard)
    local alphaIndicator = Instance.new("ImageLabel")
    alphaIndicator.Size = UDim2.new(1, 0, 1, 0)
    alphaIndicator.BackgroundTransparency = 1
    alphaIndicator.BorderSizePixel = 0
    alphaIndicator.Image = "rbxassetid://18274452449"
    alphaIndicator.ScaleType = Enum.ScaleType.Tile
    alphaIndicator.TileSize = UDim2.new(0, 6, 0, 6)
    alphaIndicator.Parent = alphaGradient
    
    local alphaIndCorner = Instance.new("UICorner")
    alphaIndCorner.CornerRadius = UDim.new(0, 6)
    alphaIndCorner.Parent = alphaIndicator
    
    local alphaIndGrad = Instance.new("UIGradient")
    alphaIndGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(112, 112, 112)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    alphaIndGrad.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.806),
        NumberSequenceKeypoint.new(1, 0)
    }
    alphaIndGrad.Parent = alphaIndicator
    
    -- RGB input
    local rgbInput = Instance.new("TextBox")
    rgbInput.AnchorPoint = Vector2.new(1, 1)
    rgbInput.Position = UDim2.new(1, -8, 1, -11)
    rgbInput.Size = UDim2.new(1, -16, 0, 18)
    rgbInput.BackgroundColor3 = Color3.fromRGB(33, 33, 35)
    rgbInput.BorderSizePixel = 0
    rgbInput.Font = Enum.Font.GothamBold
    rgbInput.Text = ""
    rgbInput.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
    rgbInput.TextColor3 = Color3.fromRGB(72, 72, 72)
    rgbInput.TextSize = 14
    rgbInput.ClearTextOnFocus = false
    rgbInput.Parent = pickerInline
    
    local rgbInputCorner = Instance.new("UICorner")
    rgbInputCorner.CornerRadius = UDim.new(0, 3)
    rgbInputCorner.Parent = rgbInput
    
    -- Color logic
    local h, s, v = default:ToHSV()
    local a = alpha
    local draggingSat = false
    local draggingHue = false
    local draggingAlpha = false
    local isOpen = false
    
    local function updateColor()
        local color = Color3.fromHSV(h, s, v)
        
        colorBtn.BackgroundColor3 = color
        colorBtnInline.BackgroundColor3 = color
        colorBtnGlow.ImageColor3 = color
        satHolder.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        huePicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        alphaPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1 - a)
        satValPicker.BackgroundColor3 = Color3.fromHSV(h, s, v)
        
        alphaIndGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(112, 112, 112)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
        }
        
        Cohoes:tween(huePicker, {Position = UDim2.new(0, (hueGradient.AbsoluteSize.X - huePicker.AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        Cohoes:tween(alphaPicker, {Position = UDim2.new(0, (alphaGradient.AbsoluteSize.X - alphaPicker.AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        Cohoes:tween(satValPicker, {Position = UDim2.new(0, s * (satHolder.AbsoluteSize.X - satValPicker.AbsoluteSize.X), 1, 1 - v * (satHolder.AbsoluteSize.Y - satValPicker.AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)
        
        rgbInput.Text = string.format("%s, %s, %s, %s",
            math.floor(color.R * 255),
            math.floor(color.G * 255),
            math.floor(color.B * 255),
            math.floor((1 - a) * 100) / 100
        )
        
        callback(color, a)
    end
    
    colorBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            local absPos = colorBtn.AbsolutePosition
            local absSize = colorBtn.AbsoluteSize
            pickerFrame.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 45)
            pickerFrame.Visible = true
        else
            pickerFrame.Visible = false
        end
    end)
    
    satBtn.MouseButton1Down:Connect(function()
        draggingSat = true
    end)
    
    hueGradient.MouseButton1Down:Connect(function()
        draggingHue = true
    end)
    
    alphaGradient.MouseButton1Down:Connect(function()
        draggingAlpha = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if draggingSat then
                local mousePos = UserInputService:GetMouseLocation()
                local offset = Vector2.new(mousePos.X, mousePos.Y - 36)
                s = math.clamp((offset - satBtn.AbsolutePosition).X / satBtn.AbsoluteSize.X, 0, 1)
                v = 1 - math.clamp((offset - satBtn.AbsolutePosition).Y / satBtn.AbsoluteSize.Y, 0, 1)
                updateColor()
            elseif draggingHue then
                local mousePos = UserInputService:GetMouseLocation()
                local offset = Vector2.new(mousePos.X, mousePos.Y - 36)
                h = math.clamp((offset - hueGradient.AbsolutePosition).X / hueGradient.AbsoluteSize.X, 0, 1)
                updateColor()
            elseif draggingAlpha then
                local mousePos = UserInputService:GetMouseLocation()
                local offset = Vector2.new(mousePos.X, mousePos.Y - 36)
                a = 1 - math.clamp((offset - alphaGradient.AbsolutePosition).X / alphaGradient.AbsoluteSize.X, 0, 1)
                updateColor()
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSat = false
            draggingHue = false
            draggingAlpha = false
        end
    end)
    
    rgbInput.FocusLost:Connect(function()
        local text = rgbInput.Text
        local values = {}
        for value in string.gmatch(text, "[^,]+") do
            table.insert(values, tonumber(value))
        end
        
        if #values == 4 then
            local r, g, b, alpha_val = values[1], values[2], values[3], values[4]
            if r and g and b and alpha_val then
                local color = Color3.fromRGB(r, g, b)
                h, s, v = color:ToHSV()
                a = 1 - alpha_val
                updateColor()
            end
        end
    end)
    
    rgbInput.Focused:Connect(function()
        Cohoes:tween(rgbInput, {TextColor3 = Color3.fromRGB(245, 245, 245)})
    end)
    
    rgbInput.FocusLost:Connect(function()
        Cohoes:tween(rgbInput, {TextColor3 = Color3.fromRGB(72, 72, 72)})
    end)
    
    updateColor()
    
    local ColorPicker = {}
    function ColorPicker:Set(color, newAlpha)
        h, s, v = color:ToHSV()
        if newAlpha then
            a = newAlpha
        end
        updateColor()
    end
    function ColorPicker:Get()
        return Color3.fromHSV(h, s, v), a
    end
    
    return ColorPicker
end

print("Enhanced UI Elements loaded!")
