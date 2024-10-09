//
//  GoogleMobileAdsManager.swift
//  CloudSage
//
//  Created by Jin Lee on 9/11/24.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    GADMobileAds.sharedInstance().start(completionHandler: nil)

    return true
  }
}

class RewardedViewModel: NSObject, ObservableObject, GADFullScreenContentDelegate {
//  @Published var coins = 0
    @Published var success = false
    @Published var adFinished = false
    private var rewardedAd: GADRewardedAd?

  func loadAd() async {
      guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMobileAdsKey") as? String else {
                 print("Failed to retrieve Google Mobile Ads key")
                 return
         }
    do {
      rewardedAd = try await GADRewardedAd.load(withAdUnitID: apiKey, request: GADRequest())
      // [START set_the_delegate]
      rewardedAd?.fullScreenContentDelegate = self
      // [END set_the_delegate]
    } catch {
      print("Failed to load rewarded ad with error: \(error.localizedDescription)")
    }
  }
  // [END load_ad]

  // [START show_ad]
  func showAd() {
    guard let rewardedAd = rewardedAd else {
      return print("Ad wasn't ready.")
    }

    rewardedAd.present(fromRootViewController: nil) {
      let reward = rewardedAd.adReward
      print("Reward amount: \(reward.amount)")
        self.onSuccess()
//      self.addCoins(reward.amount.intValue)
    }
  }
  // [END show_ad]

//  func addCoins(_ amount: Int) {
//    coins += amount
//  }

    func onSuccess() {
        success = true
    }
    func offSuccess() {
        success = false
    }
  // [START ad_events]
  func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
    print("\(#function) called")
  }

  func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
    print("\(#function) called")
  }

  func ad(
    _ ad: GADFullScreenPresentingAd,
    didFailToPresentFullScreenContentWithError error: Error
  ) {
    print("\(#function) called")
  }

  func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("\(#function) called")
  }

  func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("\(#function) called")
    adFinished = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation {
              self.adFinished = false
          }
      }
  }

  func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("\(#function) called")
    // Clear the rewarded ad.
    rewardedAd = nil
  }
  // [END ad_events]
}
