void PluginInit()
{
    g_Module.ScriptInfo.SetAuthor( "Cubemath | Gaftherman" );
    g_Module.ScriptInfo.SetContactInfo( "https://github.com/CubeMath | https://github.com/Gaftherman" );
    
    g_Hooks.RegisterHook( Hooks::Player::PlayerKilled, @PlayerKilled );

    g_Scheduler.SetInterval( "CheckPlayerSinking", 0.0 );
}

HookReturnCode PlayerKilled( CBasePlayer@ pPlayer, CBaseEntity@ pAttacker, int iGib )
{	
    if( pPlayer is null )
	    return HOOK_CONTINUE;

    Vector vecMin1 = pPlayer.pev.origin; vecMin1.x -= VEC_HUMAN_HULL_DUCK.x; vecMin1.y -= VEC_HUMAN_HULL_DUCK.y; vecMin1.z -= VEC_HUMAN_HULL_DUCK.z;
    Vector vecMax1 = pPlayer.pev.origin; vecMax1.x += VEC_HUMAN_HULL_DUCK.x; vecMax1.y += VEC_HUMAN_HULL_DUCK.y; vecMax1.z -= VEC_HUMAN_HULL_DUCK.z - 18;

    Vector vecMin2 = pPlayer.pev.origin; vecMin2.x -= -VEC_HUMAN_HULL_DUCK.x; vecMin2.y -= VEC_HUMAN_HULL_DUCK.y; vecMin2.z -= VEC_HUMAN_HULL_DUCK.z - 18;
    Vector vecMax2 = pPlayer.pev.origin; vecMax2.x += -VEC_HUMAN_HULL_DUCK.x; vecMax2.y += VEC_HUMAN_HULL_DUCK.y; vecMax2.z -= VEC_HUMAN_HULL_DUCK.z;

    Vector vecMin3 = pPlayer.pev.origin; vecMin3.x -= -VEC_HUMAN_HULL_DUCK.x; vecMin3.y -= VEC_HUMAN_HULL_DUCK.y; vecMin3.z -= VEC_HUMAN_HULL_DUCK.z;
    Vector vecMax3 = pPlayer.pev.origin; vecMax3.x += -VEC_HUMAN_HULL_DUCK.x; vecMax3.y += VEC_HUMAN_HULL_DUCK.y; vecMax3.z -= VEC_HUMAN_HULL_DUCK.z - 18;

    Vector vecMin4 = pPlayer.pev.origin; vecMin4.x -= -VEC_HUMAN_HULL_DUCK.x; vecMin4.y -= -VEC_HUMAN_HULL_DUCK.y; vecMin4.z -= VEC_HUMAN_HULL_DUCK.z;
    Vector vecMax4 = pPlayer.pev.origin; vecMax4.x += -VEC_HUMAN_HULL_DUCK.x; vecMax4.y += -VEC_HUMAN_HULL_DUCK.y; vecMax4.z -= VEC_HUMAN_HULL_DUCK.z - 18;

    TraceResult tr1, tr2, tr3, tr4;
    g_Utility.TraceLine( vecMin1, vecMax1, ignore_monsters, dont_ignore_glass, pPlayer.edict(), tr1 );
    g_Utility.TraceLine( vecMin2, vecMax2, ignore_monsters, dont_ignore_glass, pPlayer.edict(), tr2 );
    g_Utility.TraceLine( vecMin3, vecMax3, ignore_monsters, dont_ignore_glass, pPlayer.edict(), tr3 );
    g_Utility.TraceLine( vecMin4, vecMax4, ignore_monsters, dont_ignore_glass, pPlayer.edict(), tr4 );

    bool Tr1 = (tr1.flFraction != 1.0) || (tr1.fInOpen != 1.0);
    bool Tr2 = (tr2.flFraction != 1.0) || (tr2.fInOpen != 1.0);
    bool Tr3 = (tr3.flFraction != 1.0) || (tr3.fInOpen != 1.0);
    bool Tr4 = (tr4.flFraction != 1.0) || (tr4.fInOpen != 1.0);

    if( Tr1 || Tr2 || Tr3 || Tr4 )
    {
        Vector vecHeadUp = pPlayer.pev.origin; vecHeadUp.z += VEC_HUMAN_HULL_DUCK.z;
        Vector vecHeadDown = pPlayer.pev.origin; vecHeadDown.z -= VEC_HUMAN_HULL_DUCK.z;

        TraceResult trPlayer;
        g_Utility.TraceLine( vecHeadUp, vecHeadDown, dont_ignore_monsters, dont_ignore_glass, pPlayer.edict(), trPlayer );

        pPlayer.pev.origin.z = trPlayer.vecEndPos.z + VEC_HUMAN_HULL_DUCK.z;
    }

    return HOOK_CONTINUE;
}

void CheckPlayerSinking()
{
    CBaseEntity@ pFindDeadPlayers = null;
    while((@pFindDeadPlayers = g_EntityFuncs.FindEntityByClassname( pFindDeadPlayers, "deadplayer" )) !is null)
    {
        if(pFindDeadPlayers.pev.speed < 10.0 && pFindDeadPlayers.pev.movetype != 8)
        {
            if(pFindDeadPlayers.pev.movetype != 5) 
            {
                pFindDeadPlayers.pev.velocity.z -= 128.0;
                pFindDeadPlayers.pev.movetype = 5;
            }
            else
            {
                pFindDeadPlayers.pev.velocity = g_vecZero;
                pFindDeadPlayers.pev.movetype = 8;
                pFindDeadPlayers.pev.solid = SOLID_NOT;
            }
        }
    }
}