import 'package:tradplus_sdk/tradplus_sdk.dart';

final TPInterstitialManager = TPInterstitial();

class TPInterstitial {
  ///构建ExtraMap：isAutoLoad 是否开启自动记载 默认开启, customMap 流量分组等自定义数据
  Map createInterstitialExtraMap({
    Map? customMap,
    Map? localParams,
    bool openAutoLoadCallback = false,
    double maxWaitTime = 0,
  }) {
    Map extraMap = {};
    if (localParams != null) {
      extraMap['localParams'] = localParams;
    }

    if (customMap != null) {
      extraMap['customMap'] = customMap;
    }
    extraMap['openAutoLoadCallback'] = openAutoLoadCallback;
    extraMap['maxWaitTime'] = maxWaitTime;
    return extraMap;
  }

  ///加载广告：adUnitId 广告位ID, extraMap = createInterstitialExtraMap
  Future<void> loadInterstitialAd(String adUnitId, {Map? extraMap}) async {
    Map arguments = {};
    arguments['adUnitID'] = adUnitId;
    if (extraMap != null) {
      arguments['extraMap'] = extraMap;
    }
    TradplusSdk.channel.invokeMethod('interstitial_load', arguments);
  }

  ///广告是否ready：adUnitId 广告位ID
  Future<bool> interstitialAdReady(String adUnitId) async {
    return await TradplusSdk.channel
        .invokeMethod('interstitial_ready', {'adUnitID': adUnitId});
  }

  ///展示广告：adUnitId 广告位ID ,sceneId 从Tradplus后台获取到到场景ID
  Future<void> showInterstitialAd(String adUnitId, {String? sceneId}) async {
    Map arguments = {};
    arguments['adUnitID'] = adUnitId;
    if (sceneId != null) {
      arguments['sceneId'] = sceneId;
    }
    TradplusSdk.channel.invokeMethod('interstitial_show', arguments);
  }

  ///进入广告场景：adUnitId 广告位ID ,sceneId 从Tradplus后台获取到到场景ID
  Future<void> entryInterstitialAdScenario(String adUnitId,
      {String? sceneId}) async {
    Map arguments = {};
    arguments['adUnitID'] = adUnitId;
    if (sceneId != null) {
      arguments['sceneId'] = sceneId;
    }
    TradplusSdk.channel.invokeMethod('interstitial_entryAdScenario', arguments);
  }

  ///开发者通过此接口在展示前设置透传信息，透传信息可以在广告展示后的相关回调的adInfo中获取
  Future<void> setCustomAdInfo(String adUnitId, Map customAdInfo) async {
    Map arguments = {};
    arguments['adUnitID'] = adUnitId;
    arguments['customAdInfo'] = customAdInfo;
    TradplusSdk.channel.invokeMethod('interstitial_setCustomAdInfo', arguments);
  }

  ///设置广告Listener：adUnitId 设置后只返回指定广告位相关回调（可选）
  setInterstitialListener(TPInterstitialAdListener listener,
      {String adUnitId = ""}) {
    if (adUnitId.isNotEmpty) {
      TPListenerManager.interstitialAdListenerMap[adUnitId] = listener;
    } else {
      TPListenerManager.interstitialAdListener = listener;
    }
  }

  callback(TPInterstitialAdListener listener, String adUnitId, String method,
      Map arguments) {
    Map adInfo = {};
    if (arguments.containsKey("adInfo")) {
      adInfo = arguments['adInfo'];
    }
    Map error = {};
    if (arguments.containsKey("adError")) {
      error = arguments['adError'];
    }
    if (method == 'interstitial_loaded') {
      listener.onAdLoaded(adUnitId, adInfo);
    } else if (method == 'interstitial_loadFailed') {
      listener.onAdLoadFailed(adUnitId, error);
    } else if (method == 'interstitial_impression') {
      listener.onAdImpression(adUnitId, adInfo);
    } else if (method == 'interstitial_showFailed') {
      listener.onAdShowFailed(adUnitId, adInfo, error);
    } else if (method == 'interstitial_clicked') {
      listener.onAdClicked(adUnitId, adInfo);
    } else if (method == 'interstitial_closed') {
      listener.onAdClosed(adUnitId, adInfo);
    } else if (method == 'interstitial_startLoad') {
      listener.onAdStartLoad!(adUnitId, adInfo);
    } else if (method == 'interstitial_oneLayerStartLoad') {
      listener.oneLayerStartLoad!(adUnitId, adInfo);
    } else if (method == 'interstitial_bidStart') {
      listener.onBiddingStart!(adUnitId, adInfo);
    } else if (method == 'interstitial_bidEnd') {
      listener.onBiddingEnd!(adUnitId, adInfo, error);
    } else if (method == 'interstitial_isLoading') {
      listener.onAdIsLoading!(adUnitId);
    } else if (method == 'interstitial_oneLayerLoaded') {
      listener.oneLayerLoaded!(adUnitId, adInfo);
    } else if (method == 'interstitial_oneLayerLoadedFail') {
      listener.oneLayerLoadFailed(adUnitId, adInfo, error);
    } else if (method == 'interstitial_allLoaded') {
      bool isSuccess = arguments["success"];
      listener.onAdAllLoaded!(adUnitId, isSuccess);
    } else if (method == 'interstitial_playStart') {
      listener.onVideoPlayStart!(adUnitId, adInfo);
    } else if (method == 'interstitial_playEnd') {
      listener.onVideoPlayEnd!(adUnitId, adInfo);
    } else if (method == 'interstitial_downloadstart') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      listener.onDownloadStart!(adUnitId, l, l1, s, s1);
    } else if (method == 'interstitial_downloadupdate') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      int i = arguments["p"];
      listener.onDownloadUpdate!(adUnitId, l, l1, s, s1, i);
    } else if (method == 'interstitial_downloadpause') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      listener.onDownloadPause!(adUnitId, l, l1, s, s1);
    } else if (method == 'interstitial_downloadfinish') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      listener.onDownloadFinish!(adUnitId, l, l1, s, s1);
    } else if (method == 'interstitial_downloadfail') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      listener.onDownloadFail!(adUnitId, l, l1, s, s1);
    } else if (method == 'interstitial_downloadinstall') {
      num l = arguments["l"];
      num l1 = arguments["l1"];
      String s = arguments["s"];
      String s1 = arguments["s1"];
      listener.onInstall!(adUnitId, l, l1, s, s1);
    }
  }
}

class TPInterstitialAdListener {
  final Function(String adUnitId, Map adInfo) onAdLoaded;
  final Function(String adUnitId, Map error) onAdLoadFailed;
  final Function(String adUnitId, Map adInfo) onAdImpression;
  final Function(String adUnitId, Map adInfo, Map error) onAdShowFailed;
  final Function(String adUnitId, Map adInfo) onAdClicked;
  final Function(String adUnitId, Map adInfo) onAdClosed;
  final Function(String adUnitId, Map adInfo, Map error) oneLayerLoadFailed;
  final Function(String adUnitId, Map adInfo)? onAdStartLoad;
  final Function(String adUnitId, Map adInfo)? onBiddingStart;
  final Function(String adUnitId, Map adInfo, Map error)? onBiddingEnd;
  final Function(String adUnitId)? onAdIsLoading;
  final Function(String adUnitId, Map adInfo)? oneLayerStartLoad;
  final Function(String adUnitId, Map adInfo)? oneLayerLoaded;
  final Function(String adUnitId, Map adInfo)? onVideoPlayStart;
  final Function(String adUnitId, Map adInfo)? onVideoPlayEnd;
  final Function(String adUnitId, bool isSuccess)? onAdAllLoaded;
  //android only 下载回调
  final Function(String adUnitId, num l, num l1, String s, String s1)?
      onDownloadStart;
  final Function(
          String adUnitId, num l, num l1, String s, String s1, int progress)?
      onDownloadUpdate;
  final Function(String adUnitId, num l, num l1, String s, String s1)?
      onDownloadPause;
  final Function(String adUnitId, num l, num l1, String s, String s1)?
      onDownloadFinish;
  final Function(String adUnitId, num l, num l1, String s, String s1)?
      onDownloadFail;
  final Function(String adUnitId, num l, num l1, String s, String s1)?
      onInstall;
  const TPInterstitialAdListener(
      {required this.onAdLoaded,
      required this.onAdLoadFailed,
      required this.onAdImpression,
      required this.onAdShowFailed,
      required this.onAdClicked,
      required this.onAdClosed,
      required this.oneLayerLoadFailed,
      this.onAdStartLoad,
      this.onBiddingStart,
      this.onBiddingEnd,
      this.onAdIsLoading,
      this.oneLayerStartLoad,
      this.oneLayerLoaded,
      this.onAdAllLoaded,
      this.onVideoPlayStart,
      this.onVideoPlayEnd,
      this.onDownloadStart,
      this.onDownloadUpdate,
      this.onDownloadPause,
      this.onDownloadFinish,
      this.onDownloadFail,
      this.onInstall});
}
