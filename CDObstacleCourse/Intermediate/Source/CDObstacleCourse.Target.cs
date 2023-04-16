using UnrealBuildTool;

public class CDObstacleCourseTarget : TargetRules
{
	public CDObstacleCourseTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V2;
		Type = TargetType.Game;
		ExtraModuleNames.Add("CDObstacleCourse");
	}
}
