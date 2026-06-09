# Unrestricts camera min/max zoom and a few other things
{
  den.aspects.mods.halo-wars.cameraZoom = {
    homeManager =
      {
        config,
        ...
      }:
      {
        # "~/.config/MangoHud/presets.conf"
        home.file."${config.xdg.dataHome}/Steam/steamapps/common/HaloWarsDE/startup/game.cfg" = {
          text = ''
            // game.cfg
            unlockAllCampaignMissions

            // Camera
            CameraYaw=317.2
            CameraFOV=44.9

            CameraPitchMin=34
            CameraPitch=42
            CameraPitchMax=54

            CameraZoomMin=0
            CameraZoom=120
            CameraZoomMax=300

            CameraZoomRate=200.0
            CameraZoomFastFactor=2.0
            CameraRotateRate=160.0
            CameraRotateFastFactor=1.0
            CameraPitchRate=60.0
            CameraPitchFastFactor=2.0
            -CameraPitchInvert
            CameraFOVRate=5.0
            CameraAutoZoomOutRate=60.0
            CameraAutoZoomOutFastFactor=1.0
            CameraAutoZoomOutDelay=0.1
            CameraAutoZoomInRate=80.0
            CameraAutoZoomInFastFactor=1.0
            CameraAutoZoomInDelay=0.1
            CameraAutoZoomInstant
            CameraLimits
            LockCameraToWorld
            KeyboardPanSpeed=1.5

            // Scrolling
            scrollMaxSpeed 100
            scrollFastSpeed 400
            scrollRampPoint 0.6
            scrollRampSpeed 0.3
            scrollExp 2.0
            scrollRateBase 0.1
            scrollRateGrow 1.5
            delayScrollingAngle 20
            delayScrollingTime 1.0
            scrollBorderWidth 10
            scrollCornerRegionPercent 20

            // Sticky Reticle
            StickyReticle
            StickyReticleSensitivity 1.0
            StickyReticleFollow
            -StickyReticleJumpCamera
            StickyReticleJumpCameraSpeed 40.0
            StickyReticleJumpStep 1.0
            StickyReticleJumpForwardMinSpeed 40.0
            StickyReticleJumpForwardMaxSpeed 120.0
            StickyReticleJumpForwardMinDist 4.0
            StickyReticleJumpForwardMaxDist 16.0
            StickyReticleJumpBackMinSpeed 40.0
            StickyReticleJumpBackMaxSpeed 120.0
            StickyReticleJumpBackMinDist 4.0
            StickyReticleJumpBackMaxDist 16.0
            StickyReticleJumpToAngleTolerance 45.0
            StickyReticleJumpMaxSpeed 200.0
            StickyReticleJumpMinSpeed 0.0
            StickyReticleJumpMaxTime 0.8
            StickyReticleJumpMinTime 0.1
            StickyReticleJumpMinSearchScale 1.0
            StickyReticleJumpMaxSearchScale 8.0
            StickyReticleAverageSpeedInterval 1.0

            // Circle Selection
            circleSelectDelayTime 0.1
            circleSelectRate 0.1
            circleSelectRateAccel 225.0
            circleSelectMaxRate 3000.0
            circleSelectSize 0.6
            circleSelectMaxSize 24.0
            circleSelectMaxResize 24.0
            circleSelectResizeRate 20.0
            circleSelectFadeInAccel 80.0
            circleSelectEventSize 18.0

            circleSelectHover
            -circleSelectDrawMax
            circleSelectClickSize 40.0
            -circleSelectAutoDoubleClick
            debugCircleSelect 0

            // Input system
            ControllerConfig "New3"
            KeyboardMouseSchemeAllowed
            UserGamepadRumble
            GamepadDoubleClickTime 0.3
            GamepadHoldTime 0.35
            ActionWithDirectionHoldTime 0.25
            ThreadInput
            ConsoleStringLimit=500

            // Sound

            // UI
            -DisableUI
            -NoHelp
            BuildingMenuOnSelect
            ExitSubSelectOnCancel
            ExitTargetSelectOnScroll
            -DisableFlash
            FlashGameUI
            FlashMinimap
            FlashCovUI
            CrowdNeighborDistance 80.0
            GotoSlideTime 0.5
            GotoSlideAwaySpeed 0.0
            GotoSlideTowardsDistance 30.0
            GroupCreateTime 0.5
            GroupGotoTime 0.3
            ShowUnavailIcons
            BaseDecalIntensity 6.0
            SelectionDecalIntensity 15.0
            SubSelectDecalAlpha 0.4
            ShowReticuleHelp
            ObjectivesDisplay
            Objectives2
            ShowDebugMenuItems
            HUDAttackNotification
            ShowFlashObjWidget
            ShowFlashChat
            ;UsePartyRoom
            UsePartyRoom2
            NewCampaignPostgame
            NewCampaignObjectives
            NewMainMenu
            -SplitScreen
            VerticalSplit
            AIEye
            CircleSelectIntensity 0.75
            CircleSelectSizeFactor 0.59
            CircleSelectOffset 0.1
            HoverDecalSize 5.0
            HoverDecalIntensity 3.0
            HoverDecalOffset 0.1
            -SelectAllIgnoreWorking
            RecoverEffectOffset -4.0
            BillboardRecoverEffect
            FriendOrFoe
            UsePlayerMenu
            -NewEndGame
            NewSkirmishPostGame
            NewSkirmishObjective
            NewOptions
            NoSelectionHighlight
            StorageWaitMinTime 500

            // Cinematics
            //IntroCinematic="video\Bhvr_Intro.bik"
            //IntroCinematic="video\343_Intro.bik"
            //IntroCinematic2="video\MSGameStudio_Intro.bik"
            //MinIntroTime 5000
            //NoIntroCinematics
            CreditsMovie="video\uiCredits.bik"
            CreditsSubtitles="cin17.eng.xml"
            UIBackgroundMovieMain="video\uiBackground1.bik"
            UIBackgroundMovie="video\uiBackground2.bik"
            UITimelineScreenMovie="video\uiBackgroundTimeline.bik"
            UIBackgroundImg="ui\menu\background\uiBackground1"
            UIBackgroundMovieCampaign="video\uiBackground1.bik"

            // Vismap
            -NoVismap
            UseVismapFile
            -SaveVismapFil;
            BlackMaskTint 0.0

            // Skirmish game
            DefaultMap="skirmish\design\beta_1v1_cross\beta_1v1_cross"

            // Sim
            -NoFogMask
            -NoHPBar
            -NoDamage
            GameSpeed 1.0
            -PassThroughOwnVehicles
            -NoRandomPlayerPlacement
            -RecordGames
            -UsePathEngine
            -UseTestLeaders
            -EnableCapturePointResourceSharing
            ProjectionTime 0.6
            //ProjectionCollisionRatio 0.6
            //NoBirthAnims
            //Turning
            NewMovement
            BuildingQueue
            ActiveAbilities
            MoreNewMovement3
            AsyncWorldUpdate
            ExplorationRegionShowTime=5.0
            TrueLOS
            CoopSharedResources
            CoopSharedPop
            MaxProjectileHeightForDecal=4.0
            AllowAnimIsDirty
            -IgnoreGrannyRootBone
            -AllowFixedParentBone
            PercentFadeTimeCorpseSink=0.75
            CorpseSinkSpeed=0.5
            CorpseMinScale=0.7
            -BlockOutsideBounds
            -NoProtoObjectOptimization
            EnableSubUpdating
            MPSubUpdating
            AlternateSubUpdating
            DynamicSubUpdateTime
            MaxSubUpdateTime 66
            DynamicSubUpdating
            SubUpdateAvgUpdOn 25
            SubUpdateAvgUpdOff 7
            MinSubUpdateEnabledTime 10.0
            ClassicPlatoonGrouping
            UnloadRootArchive

            // Gameplay 
            Veterancy

            // Graphics
            -temporalAA
            vsync 2
            numAATiles 2
            loadModelTextures
            GammaExponent 2.645
            //LowFrameLatency
            TessellationShaders
            //ParticlePipelineCache
            ParticleDeferredContext
            ModelPipelineCache
            Multisampling
            //MaximumDisplaySize  // Will turn this on later once docking of UI elements is implemented properly

            // Multiplayer
            RejoinParty
            UseLan

            // proxy support is disabled by default
            xNet-ProxySupport

            // Sync Manager
            // compression slows down the streaming to disk
            syncManagerNoCompression
            // disabled cache drive since it's not working properly ( is not used on final eitherway )
            //syncManagerUseCacheDrive
            // if we run out of buffers, this will dynamically allocate more as needed
            // we default to 2MB worth of buffer data
            //syncManagerAllowDynamicAlloc
            -NoSync
            -DontGoOOS
            FullAllSync
            // syncHistorySize 16
            //XorAllSync
            //RandSync full
            //PlayerSync full
            //TeamSync full
            //UnitGroupSync full
            //UnitSync full1v1
            //UnitDetailSync full1v1
            //UnitActionSync full1v1
            //SquadSync full1v1
            //ProjectileSync full1v1
            //WorldSync full
            //TechSync full
            //CommandSync full
            //PathingSync full
            //MovementSync full
            //VisibilitySync full
            //FinalReleaseSync full
            //FinalDetailSync full
            //ChecksumSync full
            //TriggerSync full
            //TriggerVarSync full1v1
            //AnimSync full1v1
            //DoppleSync full
            //CommSync full
            //PlatoonSync full

            // Floaty Text
            RenderFloatyTextXVelocity=0.00
            RenderFloatyTextYVelocity=0.10
            RenderFloatyTextDuration=1500
            RenderFloatyTextFadeOutTime=1000

            // System
            DumpDirectory="\\file3\halowars\logs"
            -SystemLogging
            -noAssert
            noDebugSpew
            NoAssertDialog
            autoIgnoreAssertAfterFirstHit

            EnableGameStats
            ShowPostGame
            ShowCampaignPostGame
            EnableAttractMode
            NewSkirmish
            ShowTimeline
            ShowLeaderboards


            // Multiplayer
            -CommLogging

            // Triggers
            EnableTriggerDebugs
            EnableTriggerDebugsStatusText

            // Sim
            PlatoonRadius=50.0
            -HumanAttackMove
            EnableCorpses
            EnableMotionExtraction

            // BSuspendable validation
            SuspendableTimeChecks
            SuspendableAsserts

            // Vince 
            // Halwes 10/31/2006 - Only valid for configurations with _VINCE_ defined, currently playtest and debug
            VinceUnitInterval=30.0
            VinceBuildingInterval=30.0
            VinceResourceInterval=30.0

            // Record Games, Save Games, Screen Shots
            // GameFileDebug is enabled by default in non-final builds 
            //GameFileDebug

            // Demo
            -Demo
            DemoFadeOutTime 5.0
            TutorialMap skirmish\design\labyrinth_walk_e3\labyrinth_walk_e3
            DemoMovie="game:\video\HWE32008.bik"

            // Alpha/Beta testing
            -AlphaTest


            //Network
            SocketUnresponsiveTimeout=15000
            xNet-JoinRequestTimeout=30000
            xNet-ProxyRequestTimeout=8000
            xNet-ProxyPingTimeout=3000
            xNet-UseAddressFragment


            //LSP settings
            LSPServerFilter=HW_PROD
            LSPServiceID=0x4D530838
            LSPEnableFileUpload
            -LSPEnableAuth
            LSPEnableConfig
            LSPConfigDataPacketVersion2
            LSPEnablePerfReport
            -LSPEnableMediaTransfer
            -LSPEnableMediaCompression
            -LSPEnableTicker

            EnableXMB

            // For debugging and tweaking IK (toggle "OverrideGroundIK" on to enable this stuff)
            OverrideGroundIKRange=5.0
            OverrideGroundIKTiltFactor=0.1

            EmitterFadeStartDistance=200.0
            EmitterFadeEndDistance=300.0

            // Physics
            NumPhysicsThreads=2
            PhysicsMainThread=1
            EnableSubbreakage
            EnableThrowPart


            EnableBackgroundPlayer
            SkirmishLoadScreen
            PlayCinematicOnLoad
            FlashEnableBatching
            EnableImpactLimits
            NoWorldBorder

            // Circlemenu Blur Values
            CircleMenuBlurFactor 0.4
            CircleMenuBlurSaturation 0.5
            CircleMenuBlurDuration 0.15


            //AI Settings

            AIEye


            -EnableTriggerDebugs
            -EnableTriggerDebugsStatusText

            //AIBoost


            //Hint system settings

            EnableHintSystem


            -GrannySampleAnimCache
            EnableMusic

            -ShowCinematicSubtitles
            SubTitles

            BackgroundTextureLoading

            GameStartFadeTime 0.75
            GameStartFadeDelay 0.25

            ReloadScenarioIgnoreTime 2.0
            ReloadScenarioWaitTime 1.0

            -RecordToCacheDrive

            CTFExtraDifficulty 0.3

            OptionsMenuMaxItems 9

            MaximumSPCLifetimeLeaderboardScore 60000000
          '';
          force = true;
        };
      };
  };
}
