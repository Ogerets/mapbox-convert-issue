# mapbox-convert-issue

This sample project represents the bug in Mapbox function `MapboxMap.point(for: CLLocationCoordinate2D) -> CGPoint` when pitch of camera is non zero.

## Setup

- Run command `pod install` at command line
- Fill the `ResourceOptions` with your **accessToken** in ViewController.swift

## Environment

- Mapbox **v10.0.1**
- Xcode **12.5.1**
