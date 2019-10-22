//
//  XMLDTD+FCPXML.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

#if os(macOS)
extension XMLDTD {

    /// The FCPXML version 1.8 DTD.
    public static let fcpxml: XMLDTD = {
        let dtd = try! XMLDTD(data: dtdData, options: [])
        dtd.name = "fcpxml"
        return dtd
    }()
}

extension XMLDTD {

    private static let dtdData = dtdString.data(using: .utf8)!
    private static let dtdString = """
<!-- FCP X XML Interchange Format, Version 1.8 -->
<!-- Copyright (c) 2011-2017 Apple Inc. All rights reserved. -->
 
<!-- COMMON ENTITIES -->
 
<!-- 'time' attributes are expressed as a rational number of seconds (e.g., "1001/30000s") -->
<!-- with a 64-bit numerator and 32-bit denominator. -->
<!-- Integer 'time' values, such as 5 seconds, may be expressed as whole numbers (e.g., '5s'). -->
<!ENTITY % time "CDATA">
 
<!-- A 'timelist' is a semi-colon-separated list of time values -->
<!ENTITY % timelist "CDATA">
 
<!ENTITY % collection_item "collection-folder | keyword-collection | smart-collection">
 
<!ENTITY % event_item "clip | audition | mc-clip | ref-clip | sync-clip | asset-clip | %collection_item; | project">
 
<!-- FCPXML -->
<!ELEMENT fcpxml (import-options?, resources?, (library | event* | (%event_item;)*))>
<!ATTLIST fcpxml version CDATA #FIXED "1.8">
 
<!-- IMPORT OPTIONS -->
<!-- Element that contain options on how the import should be conducted (e.g. whether to copy assets, etc.) -->
<!ELEMENT import-options (option*)>
 
<!ELEMENT option EMPTY>
<!ATTLIST option key CDATA #REQUIRED>
<!ATTLIST option value CDATA #REQUIRED>
 
<!-- LIBRARY ELEMENT -->
<!ELEMENT library (event | smart-collection)*>
<!ATTLIST library location CDATA #IMPLIED>
<!ATTLIST library colorProcessing (standard | wide | wide-hdr) #IMPLIED>
 
<!-- EVENT ELEMENT -->
<!ELEMENT event (%event_item;)*>
<!ATTLIST event name CDATA #IMPLIED>
<!ATTLIST event uid CDATA #IMPLIED>
 
<!-- PROJECT ELEMENT -->
<!ELEMENT project (sequence)>
<!ATTLIST project name CDATA #IMPLIED>
<!ATTLIST project uid CDATA #IMPLIED>
<!ATTLIST project id ID #IMPLIED>
<!ATTLIST project modDate CDATA #IMPLIED>
 
 
<!-- RESOURCE ELEMENTS -->
<!-- A 'resource' is a project element potentially referenced by other project elements. -->
<!-- To support such references, all resource instances require a local ID attribute. -->
<!ELEMENT resources (asset | effect | format | media)*>
 
<!-- A 'media' defines a reference to new or existing media via an FCP-assigned unique identifier ('uid'). -->
<!-- If 'uid' is not specified, FCP creates a new media object as specified by the optional child element. -->
<!-- If 'projectRef' is not specified, FCP uses the default instance. -->
<!ELEMENT media (multicam | sequence)?>
<!ATTLIST media id ID #REQUIRED>
<!ATTLIST media name CDATA #IMPLIED>
<!ATTLIST media uid CDATA #IMPLIED>
<!ATTLIST media projectRef IDREF #IMPLIED>
<!ATTLIST media modDate CDATA #IMPLIED>
 
<!-- A 'format' describes video properties. -->
<!ELEMENT format EMPTY>
<!ATTLIST format id ID #REQUIRED>
<!ATTLIST format name CDATA #IMPLIED>
<!ATTLIST format frameDuration %time; #IMPLIED>
<!ATTLIST format fieldOrder CDATA #IMPLIED>            <!-- (progressive | upper first | lower first ) -->
<!ATTLIST format width CDATA #IMPLIED>
<!ATTLIST format height CDATA #IMPLIED>
<!ATTLIST format paspH CDATA #IMPLIED>
<!ATTLIST format paspV CDATA #IMPLIED>
<!ATTLIST format colorSpace CDATA #IMPLIED>            <!-- In the form of "<cp>-<tc>-<mc> (<name>)" -->
        <!--    where <cp>: color primaries, <tc>: transfer characteristics, <mc>: matrix coefficients -->
        <!--    the components are encoded as in ISO/IEC 230001-8. -->
        <!--    for the following well known colorspaces the <name> is included in parentheses: -->
        <!--    ("Rec. 601 (NTSC)" | "Rec. 601 (PAL)" | "Rec. 709" | "Rec. 2020" | "Rec. 2020 PQ" | "Rec. 2020 HLG") -->
<!ATTLIST format projection CDATA #IMPLIED>            <!-- ("none" | "equirectangular" | "cubic") -->
<!ATTLIST format stereoscopic CDATA #IMPLIED>        <!-- ("mono" | "side by side" | "over under") -->
 
 
<!-- An 'asset' defines a reference to external source media (i.e., a local file). -->
<!-- 'uid' is an FCP-assigned unique ID; if not specified, FCP creates a new default clip for the asset. -->
<!ELEMENT asset (bookmark?,metadata?)>
<!ATTLIST asset id ID #REQUIRED>
<!ATTLIST asset name CDATA #IMPLIED>
<!ATTLIST asset uid CDATA #IMPLIED>
<!ATTLIST asset src CDATA #REQUIRED>                <!-- file: URL -->
<!ATTLIST asset start %time; #IMPLIED>
<!ATTLIST asset duration %time; #IMPLIED>
<!ATTLIST asset hasVideo CDATA #IMPLIED>
<!ATTLIST asset format IDREF #IMPLIED>
<!ATTLIST asset hasAudio CDATA #IMPLIED>
<!ATTLIST asset audioSources CDATA #IMPLIED>
<!ATTLIST asset audioChannels CDATA #IMPLIED>
<!ATTLIST asset audioRate CDATA #IMPLIED>
<!ATTLIST asset customLUTOverride CDATA #IMPLIED>    <!-- Either of the following: -->
        <!-- a built-in log mode in a form of: <logID> ( <logName> ) -->
        <!--    e.g. "64 (Panasonic_VLog_VGamut)" -->
        <!-- a custom LUT in a form of: LUT:<LUTID> (<LUTName>) -->
        <!--    e.g. "LUT:f9814a42eb75c58d9d9dc2a5344bd423 (FilmConvert-Justine-3D-LUT)" -->
<!ATTLIST asset colorSpaceOverride CDATA #IMPLIED>    <!-- The same as the colorSpace attribute of the format element. -->
        <!-- In addition, the following still colorspace names are recognized: -->
        <!-- ("sRGB IEC61966-2.1" | "Adobe RGB (1998)")-->
<!ATTLIST asset projectionOverride CDATA #IMPLIED>    <!-- ("none" | "equirectangular" | "fisheye" | "back-to-back fisheye" | "cubic") -->
<!ATTLIST asset stereoscopicOverride CDATA #IMPLIED>    <!-- ("mono" | "side by side" | "over under") -->
 
<!ENTITY % md-type "( string | boolean | integer | float | date | timecode )">
 
<!ELEMENT metadata (md*)>
 
<!ELEMENT md (array?)>
<!ATTLIST md key CDATA #REQUIRED>
<!ATTLIST md value CDATA #IMPLIED>
<!ATTLIST md editable (0 | 1) "0">
<!ATTLIST md type %md-type; #IMPLIED>
<!ATTLIST md displayName CDATA #IMPLIED>
<!ATTLIST md description CDATA #IMPLIED>
<!ATTLIST md source CDATA #IMPLIED>
 
<!-- An 'effect' defines a reference to a built-in or user-defined Motion effect, FxPlug plug-in, audio bundle, or audio unit. -->
<!ELEMENT effect EMPTY>
<!ATTLIST effect id ID #REQUIRED>
<!ATTLIST effect name CDATA #IMPLIED>
<!ATTLIST effect uid CDATA #REQUIRED>
<!ATTLIST effect src CDATA #IMPLIED>
 
<!-- STORY ELEMENTS -->
 
<!-- The 'ao_attrs' entity declares the attributes common to 'anchorable' objects. -->
<!-- The 'lane' attribute specifies where the object is contained/anchored relative to its parent: -->
<!--    0 = contained inside its parent (default) -->
<!--    >0 = anchored above its parent -->
<!--    <0 = anchored below its parent -->
<!-- The 'offset' attribute defines the location of the object in the parent timeline (default is '0s'). -->
<!ENTITY % ao_attrs "
    lane CDATA #IMPLIED
    offset %time; #IMPLIED
">
 
<!-- The 'clip_attrs' entity declares the attributes common to all story elements. -->
<!-- The 'start' attribute defines a local timeline to schedule contained and anchored items. -->
<!-- The default start value is '0s'. -->
<!ENTITY % clip_attrs "
    %ao_attrs;
    name CDATA #IMPLIED
    start %time; #IMPLIED
    duration %time; #REQUIRED
    enabled (0 | 1) '1'
">
 
<!-- Where applicable the duration attribute is implied, and comes from the underlying media. -->
<!ENTITY % clip_attrs_with_optional_duration "
    %ao_attrs;
    name CDATA #IMPLIED
    start %time; #IMPLIED
    duration %time; #IMPLIED
    enabled (0 | 1) '1'
">
 
<!ENTITY % audioHz "( 32k | 44.1k | 48k | 88.2k | 96k | 176.4k | 192k )">
 
<!-- The 'media_attrs' entity declares the attributes common to media instances. -->
<!-- 'format' specifies a <format> resource ID. -->
<!-- 'tcStart' specifies the timecode origin of the media. -->
<!-- 'tcFormat' specifies the timecode display format (DF=drop frame; NDF=non-drop frame). -->
<!ENTITY % media_attrs "
    format IDREF #REQUIRED
    duration %time; #IMPLIED
    tcStart %time; #IMPLIED
    tcFormat (DF | NDF) #IMPLIED
">
 
<!ENTITY % outputChannel "( L | R | C | LFE | Ls | Rs | X )">
 
<!ENTITY % fadeType "(linear | easeIn | easeOut | easeInOut)">
 
<!-- A 'fadeIn' element animates a parameter from its min value to its implied value over a specified duration. -->
<!ELEMENT fadeIn EMPTY>
<!ATTLIST fadeIn type %fadeType; #IMPLIED>            <!-- default is 'easeIn' -->
<!ATTLIST fadeIn duration %time; #REQUIRED>
 
<!-- A 'fadeOut' element animates a parameter from its implied value to its min value over a specified duration. -->
<!ELEMENT fadeOut EMPTY>
<!ATTLIST fadeOut type %fadeType; #IMPLIED>            <!-- default is 'easeOut' -->
<!ATTLIST fadeOut duration %time; #REQUIRED>
 
<!-- A 'keyframeAnimation' element describes an animation curve using the contained 'keyframe' elements -->
<!ELEMENT keyframeAnimation (keyframe*)>
 
<!-- A 'keyframe' element describes an point along an animation curve -->
<!ELEMENT keyframe EMPTY>
<!ATTLIST keyframe time %time; #REQUIRED>
<!ATTLIST keyframe value CDATA #REQUIRED>
<!ATTLIST keyframe interp (linear | ease | easeIn | easeOut) "linear"> <!-- interpolation type for point. -->
<!ATTLIST keyframe curve (linear | smooth) "smooth"> <!-- whether the value changes smoothly over the keyframe, or linearly. -->
 
<!-- A 'mute' element suppresses audio output for a range of source media time -->
<!ELEMENT mute (fadeIn?, fadeOut?)>
<!ATTLIST mute start %time; #IMPLIED>
<!ATTLIST mute duration %time; #IMPLIED>
 
<!-- A 'param' specifies the range for a parameter over time, optionally including key-framed values. -->
<!-- Fade-in and fade-out are optional. -->
<!ELEMENT param (fadeIn?, fadeOut?, keyframeAnimation?, param*)>
<!ATTLIST param name CDATA #REQUIRED>
<!ATTLIST param key CDATA #IMPLIED>                 <!-- key is used to identify the parameter (can include a path (delimited by /) depending on the containing element -->
                                                    <!-- some parameters have localizable names which is why key is necessary (if the key attribute does not exist, the name is used)  -->
<!ATTLIST param value CDATA #IMPLIED>               <!-- initial value -->
<!ATTLIST param enabled (0 | 1) "1">
 
<!-- A 'data' specifies a chunk of data -->
<!ELEMENT data (#PCDATA)>
<!ATTLIST data key CDATA #IMPLIED>
 
<!-- A 'crop-rect' specifies crop values as a percentage of original frame height. -->
<!ELEMENT crop-rect (param*)>
<!ATTLIST crop-rect left CDATA "0">
<!ATTLIST crop-rect top CDATA "0">
<!ATTLIST crop-rect right CDATA "0">
<!ATTLIST crop-rect bottom CDATA "0">
 
<!-- A 'trim-rect' specifies trim values as a percentage of original frame height. -->
<!ELEMENT trim-rect (param*)>
<!ATTLIST trim-rect left CDATA "0">
<!ATTLIST trim-rect top CDATA "0">
<!ATTLIST trim-rect right CDATA "0">
<!ATTLIST trim-rect bottom CDATA "0">
 
<!-- A 'pan-rect' specifies the initial or final crop values for a "Ken Burns" animation. -->
<!-- The attributes of a pan-rect cannot be keyframed. -->
<!ELEMENT pan-rect EMPTY>
<!ATTLIST pan-rect left CDATA "0">
<!ATTLIST pan-rect top CDATA "0">
<!ATTLIST pan-rect right CDATA "0">
<!ATTLIST pan-rect bottom CDATA "0">
 
<!-- An 'info-asc-cdl' describes a primary color correction in the form of an ASC CDL (American Society of Cinematographers Color Decision List). -->
<!-- In FCPX XML v1.5, the ASC CDL information is placed under 'filter-video' element as comment, for example: -->
    <!-- info-asc-cdl: slope="1.0 1.0 1.0" offset="0 0 0" power="1.0 1.0 1.0" -->
<!-- Each component is a vector of "red green blue" adjustments. -->
 
<!-- The 'adjust-crop' element modifies the visible image width and height. -->
<!-- This element contains an optional adjustment for each crop mode, although only one mode is active. -->
<!ELEMENT adjust-crop (crop-rect?, trim-rect?, (pan-rect, pan-rect)?)>
<!ATTLIST adjust-crop mode (trim | crop | pan) #REQUIRED>
<!ATTLIST adjust-crop enabled (0 | 1) "1">
 
<!ELEMENT adjust-corners (param*)>
<!ATTLIST adjust-corners enabled (0 | 1) "1">
<!ATTLIST adjust-corners botLeft CDATA "0 0">
<!ATTLIST adjust-corners topLeft CDATA "0 0">
<!ATTLIST adjust-corners topRight CDATA "0 0">
<!ATTLIST adjust-corners botRight CDATA "0 0">
 
<!-- The absence 'adjust-conform' element implies "fit" -->
<!ELEMENT adjust-conform EMPTY>
<!ATTLIST adjust-conform type (fit | fill | none) "fit">
 
<!ELEMENT adjust-transform (param*)>
<!ATTLIST adjust-transform enabled (0 | 1) "1">
<!ATTLIST adjust-transform position CDATA "0 0">
<!ATTLIST adjust-transform scale CDATA "1 1">
<!ATTLIST adjust-transform rotation CDATA "0">
<!ATTLIST adjust-transform anchor CDATA "0 0">
 
<!ELEMENT adjust-blend (param*, reserved?)>
<!ATTLIST adjust-blend amount CDATA "1.0">
<!ATTLIST adjust-blend mode CDATA #IMPLIED>
 
<!ELEMENT adjust-stabilization (param*)>
<!ATTLIST adjust-stabilization type (automatic | inertiaCam | smoothCam) "automatic">
 
<!ELEMENT adjust-rollingShutter EMPTY>
<!ATTLIST adjust-rollingShutter amount (none | low | medium | high | extraHigh) "none">
 
<!ELEMENT adjust-360-transform (param*)>
<!ATTLIST adjust-360-transform enabled (0 | 1) "1">
<!ATTLIST adjust-360-transform coordinates (spherical | cartesian) #REQUIRED>
<!ATTLIST adjust-360-transform latitude CDATA "0">                <!-- for "spherical" coordinates -->
<!ATTLIST adjust-360-transform longitude CDATA "0">               <!-- for "spherical" coordinates -->
<!ATTLIST adjust-360-transform distance CDATA #IMPLIED>           <!-- for "spherical" coordinates -->
<!ATTLIST adjust-360-transform xPosition CDATA "0">               <!-- for "cartesian" coordinates -->
<!ATTLIST adjust-360-transform yPosition CDATA "0">               <!-- for "cartesian" coordinates -->
<!ATTLIST adjust-360-transform zPosition CDATA #IMPLIED>          <!-- for "cartesian" coordinates -->
<!ATTLIST adjust-360-transform xOrientation CDATA "0">
<!ATTLIST adjust-360-transform yOrientation CDATA "0">
<!ATTLIST adjust-360-transform zOrientation CDATA "0">
<!ATTLIST adjust-360-transform autoOrient (0 | 1) "1">
<!ATTLIST adjust-360-transform convergence CDATA "0">
<!ATTLIST adjust-360-transform interaxial CDATA #IMPLIED>
 
<!ELEMENT adjust-reorient (param*)>
<!ATTLIST adjust-reorient enabled (0 | 1) "1">
<!ATTLIST adjust-reorient tilt CDATA "0">
<!ATTLIST adjust-reorient pan CDATA "0">
<!ATTLIST adjust-reorient roll CDATA "0">
<!ATTLIST adjust-reorient convergence CDATA "0">
 
<!ELEMENT adjust-orientation (param*)>
<!ATTLIST adjust-orientation enabled (0 | 1) "1">
<!ATTLIST adjust-orientation tilt CDATA "0">
<!ATTLIST adjust-orientation pan CDATA "0">
<!ATTLIST adjust-orientation roll CDATA "0">
<!ATTLIST adjust-orientation fieldOfView CDATA #IMPLIED>
 
<!ELEMENT adjust-loudness EMPTY>
<!ATTLIST adjust-loudness amount CDATA #REQUIRED>
<!ATTLIST adjust-loudness uniformity CDATA #REQUIRED>
 
<!ELEMENT adjust-noiseReduction EMPTY>
<!ATTLIST adjust-noiseReduction amount CDATA #REQUIRED>
 
<!ELEMENT adjust-humReduction EMPTY>
<!ATTLIST adjust-humReduction frequency (50 | 60) #REQUIRED>
 
<!ELEMENT adjust-EQ (param*)>
<!ATTLIST adjust-EQ mode (flat | voice_enhance | music_enhance | loudness | hum_reduction | bass_boost | bass_reduce | treble_boost | treble_reduce) #REQUIRED>
 
<!ELEMENT adjust-matchEQ (data)>
 
<!-- The 'adjust-audio-enhancements' entities declare audio enhancement adjustments. -->
<!ENTITY % adjust-audio-enhancements "(adjust-loudness?, adjust-noiseReduction?, adjust-humReduction?, (adjust-EQ | adjust-matchEQ)?)">
 
<!ELEMENT adjust-volume (param*)>
<!ATTLIST adjust-volume amount CDATA "0dB">
 
<!ELEMENT adjust-panner (param*)>
<!ATTLIST adjust-panner mode CDATA #IMPLIED>
<!ATTLIST adjust-panner amount CDATA "0">
<!ATTLIST adjust-panner original_decoded_mix CDATA #IMPLIED>
<!ATTLIST adjust-panner ambient_direct_mix CDATA #IMPLIED>
<!ATTLIST adjust-panner surround_width CDATA #IMPLIED>
<!ATTLIST adjust-panner left_right_mix CDATA #IMPLIED>
<!ATTLIST adjust-panner front_back_mix CDATA #IMPLIED>
<!ATTLIST adjust-panner LFE_balance CDATA #IMPLIED>
<!ATTLIST adjust-panner rotation CDATA #IMPLIED>
<!ATTLIST adjust-panner stereo_spread CDATA #IMPLIED>
<!ATTLIST adjust-panner attenuate_collapse_mix CDATA #IMPLIED>
<!ATTLIST adjust-panner center_balance CDATA #IMPLIED>
 
<!-- The 'intrinsic-params' entities declare intrinsic video and audio adjustments. -->
<!ENTITY % intrinsic-params-video "(adjust-crop?, adjust-corners?, adjust-conform?, adjust-transform?, adjust-blend?, adjust-stabilization?, adjust-rollingShutter?, adjust-360-transform?, adjust-reorient?, adjust-orientation?)">
<!ENTITY % intrinsic-params-audio "(adjust-volume?, adjust-panner?)">
<!ENTITY % intrinsic-params "(%intrinsic-params-video;, %intrinsic-params-audio;)">
 
<!-- The 'timing-params' entity declare rate conform and time mapping adjustments. -->
<!ENTITY % timing-params "(conform-rate?, timeMap?)">
 
<!-- The 'anchor_item' entity declares the valid anchorable story elements. -->
<!-- When present, anchored items must have a non-zero 'lane' value. -->
<!ENTITY % anchor_item "audio | video | clip | title | caption | mc-clip | ref-clip | sync-clip | asset-clip | audition | spine">
 
<!-- The 'clip_item' entity declares the primary story elements that may appear inside a clip. -->
<!ENTITY % clip_item "audio | video | clip | title | mc-clip | ref-clip | sync-clip | asset-clip | audition | gap">
 
<!ENTITY % marker_item "(marker | chapter-marker | rating | keyword | analysis-marker)">
 
<!ENTITY % video_filter_item "(filter-video | filter-video-mask)">
 
<!-- An 'audio-channel-source' element adjusts playback settings for a single channel-based audio component in a clip's primary audio layout -->
<!-- The primary audio layout is comprised of all audio from elements in the primary (lane 0) storyline. -->
<!ELEMENT audio-channel-source (%adjust-audio-enhancements;, %intrinsic-params-audio;, filter-audio*, mute*)>
<!ATTLIST audio-channel-source srcCh CDATA #REQUIRED>        <!-- source audio channels (comma separated, 1-based index) -->
<!ATTLIST audio-channel-source outCh CDATA #IMPLIED>         <!-- output audio channels (comma separated, from: L,R,C,LFE,Ls,Rs,X) %outputChannel -->
<!ATTLIST audio-channel-source role CDATA #IMPLIED>          <!-- output role assignment -->
<!ATTLIST audio-channel-source start %time; #IMPLIED>
<!ATTLIST audio-channel-source duration %time; #IMPLIED>
<!ATTLIST audio-channel-source enabled (0 | 1) '1'>
<!ATTLIST audio-channel-source active (0 | 1) '1'>
 
<!-- An 'audio-role-source' element adjusts playback settings for a single role-based audio component in a clip -->
<!ELEMENT audio-role-source (%adjust-audio-enhancements;, %intrinsic-params-audio;, filter-audio*, mute*)>
<!ATTLIST audio-role-source role CDATA #REQUIRED>            <!-- role the audio component is associated with -->
<!ATTLIST audio-role-source start %time; #IMPLIED>
<!ATTLIST audio-role-source duration %time; #IMPLIED>
<!ATTLIST audio-role-source enabled (0 | 1) '1'>
<!ATTLIST audio-role-source active (0 | 1) '1'>
 
<!-- An 'audition' is a container with one active story element followed by alternative story elements. -->
<!ELEMENT audition (audio | video | title | ref-clip | asset-clip | clip | sync-clip)+ >
<!ATTLIST audition %ao_attrs;>
<!ATTLIST audition modDate CDATA #IMPLIED>
 
<!-- A 'spine' is a container for elements ordered serially in time. -->
<!-- Only one story element is active at a given time, except when a transition is present. -->
<!ELEMENT spine (%clip_item; | transition)* >
<!ATTLIST spine    %ao_attrs;>
<!ATTLIST spine name CDATA #IMPLIED>
<!ATTLIST spine format IDREF #IMPLIED>                <!-- default is same as parent -->
 
<!-- A 'sequence' is a container for a spine of story elements in a sequence project. -->
<!ELEMENT sequence (note?, spine, metadata?)>
<!ATTLIST sequence %media_attrs;>
<!ATTLIST sequence audioLayout (mono | stereo | surround) #IMPLIED>
<!ATTLIST sequence audioRate %audioHz; #IMPLIED>
<!ATTLIST sequence renderFormat CDATA #IMPLIED>
<!ATTLIST sequence keywords CDATA #IMPLIED>
 
<!-- A 'multicam' is a container for multiple "angles" of related content. -->
<!ELEMENT multicam (mc-angle*, metadata?)>
<!ATTLIST multicam %media_attrs;>
<!ATTLIST multicam renderFormat CDATA #IMPLIED>
 
<!-- An 'mc-angle' is a container for elements ordered serially in time for one angle of a multicam clip.-->
<!-- Only one story element is active at a given time, except when a transition is present. -->
<!ELEMENT mc-angle ((%clip_item; | transition)*) >
<!ATTLIST mc-angle name CDATA #IMPLIED>
<!ATTLIST mc-angle angleID CDATA #REQUIRED>
 
<!-- An 'mc-clip' element defines an edited range of a/v data from a source 'multicam' media. -->
<!ELEMENT mc-clip (note?, %timing-params;, %intrinsic-params-audio;, mc-source*, (%anchor_item;)*, (%marker_item;)*, filter-audio*, metadata?)>
<!ATTLIST mc-clip ref IDREF #REQUIRED>                <!-- 'media' ID -->
<!ATTLIST mc-clip %clip_attrs;>
<!ATTLIST mc-clip srcEnable (all | audio | video) "all">
<!ATTLIST mc-clip audioStart %time; #IMPLIED>
<!ATTLIST mc-clip audioDuration %time; #IMPLIED>
<!ATTLIST mc-clip modDate CDATA #IMPLIED>
 
<!-- An 'mc-source' element defines custom settings and filters to apply to an angle of a multicam clip or edit. -->
<!ELEMENT mc-source (audio-role-source*, %intrinsic-params-video;, (%video_filter_item;)*)>
<!ATTLIST mc-source angleID CDATA #REQUIRED>
<!ATTLIST mc-source srcEnable (all | audio | video | none) "all">
 
<!-- A 'clip' is a container for other story elements. -->
<!-- Clips have only one primary item, and zero or more anchored items. -->
<!-- Use 'audioStart' and 'audioDuration' to define J/L cuts (i.e., split edits) on composite A/V clips. -->
<!ELEMENT clip (note?, %timing-params;, %intrinsic-params;, (spine | (%clip_item;) | caption)*, (%marker_item;)*, audio-channel-source*, (%video_filter_item;)*, filter-audio*, metadata?)>
<!ATTLIST clip %clip_attrs;>
<!ATTLIST clip format IDREF #IMPLIED>                 <!-- default is same as parent -->
<!ATTLIST clip audioStart %time; #IMPLIED>
<!ATTLIST clip audioDuration %time; #IMPLIED>
<!ATTLIST clip tcStart %time; #IMPLIED>               <!-- clip timecode origin -->
<!ATTLIST clip tcFormat (DF | NDF) #IMPLIED>          <!-- timecode display format (DF=drop frame; NDF=non-drop frame) -->
<!ATTLIST clip modDate CDATA #IMPLIED>
 
<!-- A 'ref-clip' is a clip that references (rather than contains) other story elements. -->
<!-- Clips have a media reference and zero or more anchored items. -->
<!-- Use 'audioStart' and 'audioDuration' to define J/L cuts (i.e., split edits) on composite A/V clips. -->
<!ELEMENT ref-clip (note?, %timing-params;, %intrinsic-params;, (%anchor_item;)*, (%marker_item;)*, audio-role-source*, (%video_filter_item;)*, filter-audio*, metadata?)>
<!ATTLIST ref-clip ref IDREF #REQUIRED>               <!-- 'media' ID -->
<!ATTLIST ref-clip %clip_attrs;>
<!ATTLIST ref-clip srcEnable (all | audio | video) "all">
<!ATTLIST ref-clip audioStart %time; #IMPLIED>
<!ATTLIST ref-clip audioDuration %time; #IMPLIED>
<!ATTLIST ref-clip useAudioSubroles (0 | 1) '0'>
<!ATTLIST ref-clip modDate CDATA #IMPLIED>
 
<!-- A 'sync-clip' is a container for other story elements that are used as a synchronized clip. -->
<!-- Use 'audioStart' and 'audioDuration' to define J/L cuts (i.e., split edits) on composite A/V clips. -->
<!ELEMENT sync-clip (note?, %timing-params;, %intrinsic-params;, (spine | (%clip_item;) | caption)*, (%marker_item;)*, sync-source*, (%video_filter_item;)*, filter-audio*, metadata?)>
<!ATTLIST sync-clip %clip_attrs;>
<!ATTLIST sync-clip format IDREF #IMPLIED>              <!-- default is same as parent -->
<!ATTLIST sync-clip audioStart %time; #IMPLIED>
<!ATTLIST sync-clip audioDuration %time; #IMPLIED>
<!ATTLIST sync-clip tcStart %time; #IMPLIED>            <!-- clip timecode origin -->
<!ATTLIST sync-clip tcFormat (DF | NDF) #IMPLIED>       <!-- timecode display format (DF=drop frame; NDF=non-drop frame) -->
<!ATTLIST sync-clip modDate CDATA #IMPLIED>
 
<!-- A 'sync-source' element defines the role-based audio components to be used for a source of a synchronized clip. -->
<!ELEMENT sync-source (audio-role-source*)>
<!ATTLIST sync-source sourceID (storyline | connected) #REQUIRED>
 
<!-- An 'asset-clip' is a clip that references an asset. -->
<!-- All available media components in the asset are implicitly included. -->
<!-- Clips have a media reference and zero or more anchored items. -->
<!-- Use 'audioStart' and 'audioDuration' to define J/L cuts (i.e., split edits) on composite A/V clips. -->
<!ELEMENT asset-clip (note?, %timing-params;, %intrinsic-params;, (%anchor_item;)*, (%marker_item;)*, audio-channel-source*, (%video_filter_item;)*, filter-audio*, metadata?)>
<!ATTLIST asset-clip ref IDREF #REQUIRED>                    <!-- 'asset' ID -->
<!ATTLIST asset-clip %clip_attrs_with_optional_duration;>    <!-- duration defaults to that of the respective asset -->
<!ATTLIST asset-clip srcEnable (all | audio | video) "all">
<!ATTLIST asset-clip audioStart %time; #IMPLIED>
<!ATTLIST asset-clip audioDuration %time; #IMPLIED>
<!ATTLIST asset-clip format IDREF #IMPLIED>                  <!-- default is same as parent -->
<!ATTLIST asset-clip tcStart %time; #IMPLIED>                <!-- clip timecode origin -->
<!ATTLIST asset-clip tcFormat (DF | NDF) #IMPLIED>           <!-- timecode display format (DF=drop frame; NDF=non-drop frame) -->
<!ATTLIST asset-clip modDate CDATA #IMPLIED>
<!ATTLIST asset-clip audioRole CDATA #IMPLIED>
<!ATTLIST asset-clip videoRole CDATA #IMPLIED>               <!-- default is 'video' -->
 
<!-- An 'audio' element defines a range of audio data in a source asset. -->
<!ELEMENT audio (note?, %timing-params;, adjust-volume?, (%anchor_item;)*, (%marker_item;)*, filter-audio*)>
<!ATTLIST audio ref IDREF #REQUIRED>                 <!-- 'asset' or 'effect' ID -->
<!ATTLIST audio %clip_attrs;>
<!ATTLIST audio srcID CDATA #IMPLIED>                <!-- source/track identifier in asset (if not '1') -->
<!ATTLIST audio role CDATA #IMPLIED>
<!ATTLIST audio srcCh CDATA #IMPLIED>                <!-- source audio channels in asset (comma separated, 1-based index) -->
<!ATTLIST audio outCh CDATA #IMPLIED>                <!-- output audio channels (comma separated, from: L,R,C,LFE,Ls,Rs,X) %outputChannel -->
 
<!-- A 'video' element defines a range of video data in a source asset. -->
<!ELEMENT video (param*, note?, %timing-params;, %intrinsic-params-video;, (%anchor_item;)*, (%marker_item;)*, (%video_filter_item;)*, reserved?)>
<!ATTLIST video ref IDREF #REQUIRED>                 <!-- 'asset' or 'effect' ID -->
<!ATTLIST video %clip_attrs;>
<!ATTLIST video srcID CDATA #IMPLIED>                <!-- source/track identifier in asset (if not '1') -->
<!ATTLIST video role CDATA #IMPLIED>                 <!-- default is 'video' -->
 
<!-- A ‘caption' element contains one or more 'text' elements that customize a referenced caption text. -->
<!ELEMENT caption (text*, text-style-def*, note?)>
<!ATTLIST caption %clip_attrs;>                      <!-- name, start, duration, enabled, lane, offset -->
<!ATTLIST caption role CDATA #IMPLIED>
 
<!-- A 'gap' element defines a placeholder with no associated media. -->
<!-- Gaps cannot be anchored to other objects. -->
<!ELEMENT gap (note?, (%anchor_item;)*, (%marker_item;)*, metadata?)>
<!ATTLIST gap name CDATA #IMPLIED>
<!ATTLIST gap offset %time; #IMPLIED>
<!ATTLIST gap start %time; #IMPLIED>
<!ATTLIST gap duration %time; #REQUIRED>
<!ATTLIST gap enabled (0 | 1) "1">
 
<!-- A 'title' element contains one or more 'text' elements that customize a referenced effect. -->
<!ELEMENT title (param*, text*, text-style-def*, note?, %intrinsic-params-video;, (%anchor_item;)*, (%marker_item;)*, (%video_filter_item;)*, metadata?)>
<!ATTLIST title ref IDREF #REQUIRED>                <!-- 'effect' ID for a Motion template -->
<!ATTLIST title %clip_attrs;>
<!ATTLIST title role CDATA #IMPLIED>
 
<!-- A 'text' element defines an unformatted text string for a 'title' element. -->
<!ELEMENT text (#PCDATA | text-style)*>
 
<!ATTLIST text display-style (pop-on | paint-on | roll-up) #IMPLIED>  <!-- for a CEA-608 caption text block -->
<!ATTLIST text roll-up-height CDATA #IMPLIED>                         <!-- for a CEA-608 caption text block with roll-up animation -->
<!ATTLIST text position CDATA #IMPLIED>                               <!-- for a CEA-608 caption text block, as "x y" -->
<!ATTLIST text placement (left | right | top | bottom) "bottom">      <!-- for a ITT caption text block -->
<!ATTLIST text alignment (left | center | right ) #IMPLIED>           <!-- for a CEA-608 caption text block -->
 
<!ELEMENT text-style-def (text-style)>
<!ATTLIST text-style-def id ID #REQUIRED>
<!ATTLIST text-style-def name CDATA #IMPLIED>
 
<!-- A 'text-style-def' element defines the style for a formatted text string in a 'text' element. -->
<!ELEMENT text-style (#PCDATA | param)*>
<!ATTLIST text-style ref IDREF #IMPLIED>
<!ATTLIST text-style font CDATA #IMPLIED>
<!ATTLIST text-style fontSize CDATA #IMPLIED>
<!ATTLIST text-style fontFace CDATA #IMPLIED>
<!ATTLIST text-style fontColor CDATA #IMPLIED>
<!ATTLIST text-style backgroundColor CDATA #IMPLIED>    <!-- for captions -->
<!ATTLIST text-style bold (0 | 1) #IMPLIED>
<!ATTLIST text-style italic (0 | 1) #IMPLIED>
<!ATTLIST text-style strokeColor CDATA #IMPLIED>
<!ATTLIST text-style strokeWidth CDATA #IMPLIED>
<!ATTLIST text-style baseline CDATA #IMPLIED>
<!ATTLIST text-style shadowColor CDATA #IMPLIED>
<!ATTLIST text-style shadowOffset CDATA #IMPLIED>
<!ATTLIST text-style shadowBlurRadius CDATA #IMPLIED>
<!ATTLIST text-style kerning CDATA #IMPLIED>
<!ATTLIST text-style alignment (left | center | right | justified) #IMPLIED>
<!ATTLIST text-style lineSpacing CDATA #IMPLIED>
<!ATTLIST text-style tabStops CDATA #IMPLIED>
<!ATTLIST text-style baselineOffset CDATA #IMPLIED>
<!ATTLIST text-style underline (0 | 1) #IMPLIED>        <!-- for captions -->
 
<!-- A 'transition' element defines an effect that overlaps two adjacent story elements. -->
<!-- For example,
    <video ref="1" duration="5s"/>
    <transition duration="2s"/>
    <video ref="3" duration="5s"/>
Here, the transition element overlaps the last 2 seconds of the previous video (ref="1") and the first 2 seconds of the next video (ref="3"). -->
<!ELEMENT transition (filter-video?, filter-audio?, (%marker_item;)*, metadata?, reserved?)>
<!ATTLIST transition name CDATA #IMPLIED>
<!ATTLIST transition offset %time; #IMPLIED>
<!ATTLIST transition duration %time; #REQUIRED>
 
<!-- A 'filter-video' defines a video effect including intrinsic color filter effect that's applied to its parent element. -->
<!-- Video filters are concatenated in the order in which they appear. -->
<!-- There may be a comment in the form of 'info-asc-cdl' element that describes the correction, if it's the Final Cut Pro X's intrinsic color correction filter. -->
<!ELEMENT filter-video (info-asc-cdl?, data?, param*)>
<!ATTLIST filter-video ref IDREF #REQUIRED>                <!-- 'effect' ID -->
<!ATTLIST filter-video name CDATA #IMPLIED>
<!ATTLIST filter-video enabled (0 | 1) "1">
 
<!ENTITY % mask_item "(mask-shape | mask-isolation)">
 
<!-- A 'filter-video-mask' defines a video effect with a mask applied to its parent element. -->
<!-- The mask may consist of multiple shapes or color isolation. -->
<!-- For a color correction filter, in addition to the correction applied inside the mask, -->
<!-- There may be another set of correction parameters applied outside the mask. -->
<!-- For example,
    <filter-video-mask>
        <mask-shape name="Shape Mask" blendMode="add">
            <param name="Radius" key="160" value="750 150"/>
            <param name="Curvature" key="159" value="0.7"/>
            <param name="Feather" key="102" value="170"/>
            <param name="Transforms" key="200">
                <param name="Position" key="201" value="10 110"/>
                <param name="Rotation" key="202" value="14"/>
            </param>
        </mask-shape>
        <filter-video ref="100"/>
    </filter-video-mask>
    This represents a masked video filter with a single shape mask. -->
<!-- Another example,
    <filter-video-mask>
        <mask-shape name="Shape Mask" blendMode="add">
            <param name="Curvature" key="159" value="0.7"/>
            <param name="Transforms" key="200">
                <param name="Position" key="201" value="260 -30"/>
            </param>
        </mask-shape>
        <filter-video ref="1000">
            <param name="color_global" value="0.2 0.8"/>
        </filter-video>
        <filter-video ref="1000"/>
            <param name="color_highlight" value="0.3 0.6"/>
        </filter-video>
    </filter-video-mask>
    This represents a color correction filter with a single shape mask and different correction parameters applied inside and outside of the mask.
    Note the first 'filter-video' element represents the inner correction and the second corresponds to the outer correction. -->
<!-- Video filters are concatenated in the order in which they appear. -->
<!ELEMENT filter-video-mask ((%mask_item;)+, (filter-video, filter-video?))>    <!-- second filter-video is for outer color correction only -->
<!ATTLIST filter-video-mask enabled (0 | 1) "1">
<!ATTLIST filter-video-mask inverted (0 | 1) "0">
 
<!-- The 'mask-shape' element describes a shape mask used for a mask filter. -->
<!ELEMENT mask-shape (param*)>
<!ATTLIST mask-shape name CDATA #IMPLIED>
<!ATTLIST mask-shape enabled (0 | 1) "1">
<!ATTLIST mask-shape blendMode (add | subtract | multiply) "add">
 
<!-- The 'mask-isolation' element describes a color mask used for mask filter. -->
<!ELEMENT mask-isolation (data, param*)>
<!ATTLIST mask-isolation name CDATA #IMPLIED>
<!ATTLIST mask-isolation enabled (0 | 1) "1">
<!ATTLIST mask-isolation blendMode (add | subtract | multiply) "multiply">
 
<!-- A 'filter-audio' defines an audio effect that's applied to its parent element. -->
<!-- Audio filters are concatenated in the order in which they appear. -->
<!ELEMENT filter-audio (data?, param*)>
<!ATTLIST filter-audio ref IDREF #REQUIRED>                <!-- 'effect' ID -->
<!ATTLIST filter-audio name CDATA #IMPLIED>
<!ATTLIST filter-audio enabled (0 | 1) "1">
<!ATTLIST filter-audio presetID CDATA #IMPLIED>
 
<!-- A 'conform-rate' defines how the clip's frame rate should be conformed to the sequence frame rate -->
<!ELEMENT conform-rate EMPTY>
<!ATTLIST conform-rate scaleEnabled (0 | 1) "1">
<!ATTLIST conform-rate srcFrameRate (23.98 | 24 | 25 | 29.97 | 30 | 60 | 47.95 | 48 | 50 | 59.94) #IMPLIED>
<!ATTLIST conform-rate frameSampling (floor | nearest-neighbor | frame-blending | optical-flow-classic | optical-flow) "floor">
 
<!-- A 'timeMap' is a container for 'timept' elements that change the output speed of the clip's local timeline. -->
<!-- When present, a 'timeMap' defines a new adjusted time range for the clip using the first and last 'timept' elements. -->
<!-- All other time values are interpolated from the specified 'timept' elements. -->
<!ELEMENT timeMap (timept)*>
<!ATTLIST timeMap frameSampling (floor | nearest-neighbor | frame-blending | optical-flow-classic | optical-flow) "floor">
<!ATTLIST timeMap preservesPitch (0 | 1) "1">
 
<!-- A 'timept' defines the re-mapped time values for a 'timeMap'. -->
<!-- For example,
    <timeMap>
        <timept time="0s" value="0s" interp="linear"/>
        <timept time="10s" value="5s" interp="linear"/>
        <timept time="20s" value="0s" interp="linear"/>
    </timeMap>
Here, when applied to a clip whose original timeline was 0-5s, the 'timeMap' will adjust the clip's timeline to 0-20s
and play the original content at 50% speed, followed by -50% speed. -->
<!ELEMENT timept EMPTY>
<!ATTLIST timept time %time; #REQUIRED>                <!-- new adjusted clip time -->
<!ATTLIST timept value CDATA #REQUIRED>                <!-- original clip time -->
<!ATTLIST timept interp (smooth2 | linear | smooth) "smooth2"> <!-- interpolation type for point.  smooth has been deprecated -->
<!ATTLIST timept inTime %time; #IMPLIED>               <!-- transition in-time for point (used only with smooth interpolations) -->
<!ATTLIST timept outTime %time; #IMPLIED>              <!-- transition out-time for point (used only with smooth interpolations) -->
 
 
<!-- KEYWORDS, MARKERS, NOTES -->
<!-- If 'completed' is specified, this marker becomes a to-do item. -->
<!ELEMENT marker EMPTY>
<!ATTLIST marker start %time; #REQUIRED>
<!ATTLIST marker duration %time; #IMPLIED>
<!ATTLIST marker value CDATA #REQUIRED>
<!ATTLIST marker completed CDATA #IMPLIED>            <!-- (0=not completed, 1=completed) -->
<!ATTLIST marker note CDATA #IMPLIED>
 
<!ELEMENT rating EMPTY>
<!ATTLIST rating name CDATA #IMPLIED>
<!ATTLIST rating start %time; #IMPLIED>
<!ATTLIST rating duration %time; #IMPLIED>
<!ATTLIST rating value (favorite | reject) #REQUIRED>
<!ATTLIST rating note CDATA #IMPLIED>
 
<!ELEMENT keyword EMPTY>
<!ATTLIST keyword start %time; #IMPLIED>
<!ATTLIST keyword duration %time; #IMPLIED>
<!ATTLIST keyword value CDATA #REQUIRED>            <!-- comma-separated list of keywords -->
<!ATTLIST keyword note CDATA #IMPLIED>
 
<!ELEMENT analysis-marker (shot-type | stabilization-type)+>
<!ATTLIST analysis-marker start %time; #IMPLIED>
<!ATTLIST analysis-marker duration %time; #IMPLIED>
 
<!ELEMENT keyword-collection EMPTY>
<!ATTLIST keyword-collection name CDATA #REQUIRED>
 
<!ELEMENT collection-folder (%collection_item;)*>
<!ATTLIST collection-folder name CDATA #REQUIRED>
 
<!-- SMART COLLECTIONS -->
<!ELEMENT smart-collection ((match-text | match-ratings | match-media | match-clip | match-stabilization | match-keywords | match-shot | match-property | match-time | match-timeRange | match-roles)*)>
<!ATTLIST smart-collection name CDATA #REQUIRED>
<!ATTLIST smart-collection match (any | all) #REQUIRED>
 
<!ELEMENT match-text EMPTY>
<!ATTLIST match-text enabled (0 | 1) "1">
<!ATTLIST match-text rule (includes | doesNotInclude | is | isNot) "includes">
<!ATTLIST match-text value CDATA #REQUIRED>
 
<!ELEMENT match-ratings EMPTY>
<!ATTLIST match-ratings enabled (0 | 1) "1">
<!ATTLIST match-ratings value (favorites | rejected) #REQUIRED>
 
<!ELEMENT match-media EMPTY>
<!ATTLIST match-media enabled (0 | 1) "1">
<!ATTLIST match-media rule (is | isNot) "is">
<!ATTLIST match-media type (videoWithAudio | videoOnly | audioOnly | stills) #REQUIRED>
 
<!ELEMENT match-clip EMPTY>
<!ATTLIST match-clip enabled (0 | 1) "1">
<!ATTLIST match-clip rule (is | isNot) "is">
<!ATTLIST match-clip type (audition | synchronized | compound | multicam | layeredGraphic | project) #REQUIRED>
 
<!ELEMENT match-stabilization (stabilization-type*)>
<!ATTLIST match-stabilization enabled (0 | 1) "1">
<!ATTLIST match-stabilization rule (includesAny | includesAll | doesNotIncludeAny | doesNotIncludeAll) "includesAny">
 
<!ELEMENT match-keywords (keyword-name*)>
<!ATTLIST match-keywords enabled (0 | 1) "1">
<!ATTLIST match-keywords rule (includesAny | includesAll | doesNotIncludeAny | doesNotIncludeAll) "includesAny">
 
<!ELEMENT keyword-name EMPTY>
<!ATTLIST keyword-name value CDATA #REQUIRED>
 
<!ELEMENT match-shot (shot-type*)>
<!ATTLIST match-shot enabled (0 | 1) "1">
<!ATTLIST match-shot rule (includesAny | includesAll | doesNotIncludeAny | doesNotIncludeAll) "includesAny">
 
<!ELEMENT shot-type EMPTY>
<!ATTLIST shot-type value (onePerson | twoPersons | group | closeUp | mediumShot | wideShot) #REQUIRED>
 
<!ELEMENT stabilization-type EMPTY>
<!ATTLIST stabilization-type value (excessiveShake) #REQUIRED>
 
<!ELEMENT match-property EMPTY>
<!ATTLIST match-property enabled (0 | 1) "1">
<!ATTLIST match-property key (reel | scene | take | audioOutputChannels | frameSize | videoFrameRate | audioSampleRate | cameraName | cameraAngle) #REQUIRED>
<!ATTLIST match-property rule (includes | doesNotInclude | is | isNot) "includes">
<!ATTLIST match-property value CDATA #REQUIRED>
 
<!ELEMENT match-time EMPTY>
<!ATTLIST match-time enabled (0 | 1) "1">
<!ATTLIST match-time type (contentCreated | dateImported) #REQUIRED>
<!ATTLIST match-time rule (is | isBefore | isAfter) #REQUIRED>
<!ATTLIST match-time value CDATA #REQUIRED>
 
<!ELEMENT match-timeRange EMPTY>
<!ATTLIST match-timeRange enabled (0 | 1) "1">
<!ATTLIST match-timeRange type (contentCreated | dateImported) #REQUIRED>
<!ATTLIST match-timeRange rule (isInLast | isNotInLast) #REQUIRED>
<!ATTLIST match-timeRange value CDATA #REQUIRED>
<!ATTLIST match-timeRange units (hour | day | week | month | year) #IMPLIED>
 
<!ELEMENT match-roles (role*)>
<!ATTLIST match-roles enabled (0 | 1) "1">
<!ATTLIST match-roles rule (includesAny | includesAll | doesNotIncludeAny | doesNotIncludeAll) "includesAny">
 
<!ELEMENT role EMPTY>
<!ATTLIST role name CDATA #REQUIRED>
 
<!ELEMENT chapter-marker EMPTY>
<!ATTLIST chapter-marker start %time; #REQUIRED>
<!ATTLIST chapter-marker duration %time; #IMPLIED>
<!ATTLIST chapter-marker value CDATA #REQUIRED>
<!ATTLIST chapter-marker note CDATA #IMPLIED>
<!ATTLIST chapter-marker posterOffset %time; #IMPLIED>
 
<!ELEMENT note (#PCDATA)>
 
<!ELEMENT bookmark (#PCDATA)>
<!ELEMENT reserved (#PCDATA)>
 
<!ELEMENT array (string*)>
<!ELEMENT string (#PCDATA)>
"""
}
#endif
