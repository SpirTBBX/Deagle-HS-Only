#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "SpirT"
#define PLUGIN_VERSION "1.0"

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <cstrike>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "[SpirT] Deagle HS Only",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = ""
};

public void OnPluginStart()
{
	for(int i = 1; i <= MaxClients; i++)
	{
		if(IsClientConnected(i) && IsClientInGame(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
		}
	}
}


public void OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if(IsClientConnected(attacker) && IsClientInGame(attacker))
	{
		char sWeapon[32];
		GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
		
		if (StrEqual(sWeapon, "weapon_deagle"))
		{
			if(damagetype &= CS_DMG_HEADSHOT)
			{
				return Plugin_Continue;
			}
			
			damage = 0.0;
			return Plugin_Changed;
		}
		else
		{
			return Plugin_Continue;
		}
	}
	return Plugin_Continue;
}