
Scriptname NPCForceGreetScript extends Actor

float Property TriggerRadius = 1000.0 Auto  ; Radius within which the player is detected
float Property ChanceToGreet = 0.25 Auto   ; 25% chance for the NPC to greet

Event OnCellAttach()
    ; Trigger when the NPC is loaded into the game world
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    ; Check for the player's proximity
    if PlayerIsNearby() && RandomFloat(0.0, 1.0) <= ChanceToGreet
        ForceGreetPlayer()
    EndIf
    RegisterForSingleUpdate(1.0) ; Keep running every second
EndEvent

Function ForceGreetPlayer()
    ; Make the NPC greet the player
    if Game.GetPlayer() != None && !IsDead() && !IsInCombat()
        StartConversation(Game.GetPlayer())
    EndIf
EndFunction

Function bool PlayerIsNearby()
    ; Check if the player is within the trigger radius
    Actor player = Game.GetPlayer()
    if player != None
        float distance = player.GetDistance(Self)
        return distance <= TriggerRadius
    EndIf
    return false
EndFunction
