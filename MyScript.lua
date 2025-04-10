local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Flying = false
local Speed = 50

function Fly()
	local Character = Player.Character
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart)
	local BodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart)

	BodyGyro.P = 9e4
	BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	BodyGyro.cframe = HumanoidRootPart.CFrame

	BodyVelocity.velocity = Vector3.new(0,0,0)
	BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

	local control = {f = 0, b = 0, l = 0, r = 0, up = 0, down = 0}
	local lastControl = control

	local function onInput(input, isProcessed)
		if isProcessed then return end
		if input.KeyCode == Enum.KeyCode.W then control.f = 1 end
		if input.KeyCode == Enum.KeyCode.S then control.b = 1 end
		if input.KeyCode == Enum.KeyCode.A then control.l = 1 end
		if input.KeyCode == Enum.KeyCode.D then control.r = 1 end
		if input.KeyCode == Enum.KeyCode.Space then control.up = 1 end
		if input.KeyCode == Enum.KeyCode.LeftControl then control.down = 1 end
	end

	local function onInputEnded(input)
		if input.KeyCode == Enum.KeyCode.W then control.f = 0 end
		if input.KeyCode == Enum.KeyCode.S then control.b = 0 end
		if input.KeyCode == Enum.KeyCode.A then control.l = 0 end
		if input.KeyCode == Enum.KeyCode.D then control.r = 0 end
		if input.KeyCode == Enum.KeyCode.Space then control.up = 0 end
		if input.KeyCode == Enum.KeyCode.LeftControl then control.down = 0 end
	end

	game:GetService("UserInputService").InputBegan:Connect(onInput)
	game:GetService("UserInputService").InputEnded:Connect(onInputEnded)

	Flying = true
	while Flying do
		wait()
		local direction = Vector3.new(control.l + -control.r, control.up + -control.down, control.b + -control.f)
		local camCF = workspace.CurrentCamera.CFrame
		BodyVelocity.velocity = (camCF.lookVector * -direction.Z + camCF.RightVector * direction.X + camCF.UpVector * direction.Y) * Speed
		BodyGyro.CFrame = camCF
	end
	BodyGyro:Destroy()
	BodyVelocity:Destroy()
end

-- toggle ด้วยปุ่ม F
Mouse.KeyDown:Connect(function(key)
	if key:lower() == "f" then
		Flying = not Flying
		if Flying then
			Fly()
		end
	end
end)
