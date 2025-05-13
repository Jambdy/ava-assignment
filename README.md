# ava-assignment

Flutter application for Ava take home assignment.

### Static Site
The static site is hosted in an AWS S3 bucket and can be viewed at the following URL: http://ava-assignment-james-abdy.s3-website-us-east-1.amazonaws.com/

### Building generated files

Generated files are not included in the repository. To build and run locally, run the following
command:

```
dart run build_runner build
```

### Refreshing Dummy Data

A refresh icon is included in the Home app bar to help demonstrate animations. A simulated
response time of 200 milliseconds is used for all mocked API calls and can be updated in the
lib/constants/constants.dart file.

### Assumptions

#### Home screen

- Negative credit score change is shown with a red background
- Credit Factor items match existing App (titles and order, not impact)
- Only Cog icon is interactive on Home screen (other buttons and links inert)
- Data related to credit report is returned in the same API response
- Total balance/total limit is sum of individual credit card accounts

#### Employment Screen

- Employment Information persisted on Commit button click
- Employment Information form starts as editable if no data is available

#### General

- Maximum width is 600, and only width is responsive
- Maximum animation duration is 2 seconds
- Fade-in page transitions
- Error color is standard red

### Deviations from wireframes

- Update order of fields in non-editable view to match editable view in Employment Information
  form
- Default material icons used
- “At Slam Cnd” replaced with "Bebas Neue" or "Oswald" with reduced size
- "At Hauss" replaced with "Liter"
- Fix typo in "Feeback" on Feedback form

These are items that I would normally discuss with UX prior to feature implementation. The
additional fonts/icons could be imported in pubspec.yaml if .ttf files were provided.

### Potential Improvements

- Implement GitHub actions for CI/CD, including the following:
    - run tests
    - check formatting
    - build generated files
    - build web release
    - upload to S3
- Add unit tests for business logic in ViewModels
- Advanced address validation (ex. use package flutter_google_places)
- Mock error responses for API calls
- Update CreditScore dummy data to align (get current score/delta from score history)
- Add splash screen on initial Home load
- Add App Icon/favicon

### References for MVVM pattern

- https://docs.flutter.dev/app-architecture
- https://github.com/namanh11611/flutter_mvvm_riverpod