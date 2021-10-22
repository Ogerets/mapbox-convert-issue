# mapbox-convert-issue

This sample project represents the bug in Mapbox function `MGLMapView.convert(:CLLocationCoordinate2D, toPointTo:UIView?)` when pitch of camera is non zero.

## Setup

- Run command `pod install` at command line
- Fill the **MGLMapboxAccessToken** at `Info.plist` with your token
