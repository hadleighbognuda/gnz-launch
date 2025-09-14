# Glider Tow App - Detailed UI Screenshots Description

## Screen 1: Home Screen

**Visual Layout:**
- **Header Section (Top 1/3 of screen):**
  - Large airplane icon (🛩️) in blue, centered
  - "Glider Tow Registration" title in large, bold text
  - "Register your flight details" subtitle in smaller gray text
  - Generous white space around elements

- **Main Action Section (Middle 1/3):**
  - Single prominent blue button spanning most of the width
  - Button contains: Plus icon + "New Flight Registration" text
  - Button height: 60pt for easy tapping
  - Rounded corners (15pt radius)

- **Recent Registrations Section (Bottom 1/3):**
  - "Recent Registrations" header
  - Card-based layout showing past entries
  - Each card shows: Tow plane, glider, pilot ID, and timestamp
  - Light gray background for cards
  - Scrollable if more than 3-4 entries

**Color Scheme:**
- Background: Pure white
- Text: Dark gray (#333333)
- Button: iOS blue (#007AFF)
- Cards: Light gray (#F5F5F5)

## Screen 2: Registration Form

**Visual Layout:**
- **Navigation Bar:**
  - "Cancel" button on left (red text)
  - "Flight Registration" title in center
  - Clean, minimal design

- **Form Sections (Vertical Stack):**
  
  **1. Tow Plane Details Section:**
  - Section header with airplane icon and "Tow Plane Details"
  - Two input fields with labels above:
    - "Tow Plane Registration" with placeholder text
    - "Tow Plane Pilot Name" with placeholder text
  - Light gray background for the entire section
  
  **2. Glider Details Section:**
  - Section header with airplane icon and "Glider Details"
  - Single input field:
    - "Glider Registration" with placeholder text
  - Light gray background for the section
  
  **3. Glider Pilots Section:**
  - Section header with people icon and "Glider Pilots"
  - Two input fields:
    - "Primary Pilot ID (Billing)" - required field
    - "Secondary Pilot ID (Optional)" - optional field
  - Light gray background for the section

- **Action Buttons (Bottom):**
  - "Register Flight" button (blue, full-width, 60pt height)
  - "Clear Form" button (light gray, full-width, 50pt height)
  - Both buttons have rounded corners

**Input Field Design:**
- Label above each field in 18pt medium weight
- Text field with light gray background
- 18pt font size for input text
- Rounded corners (10pt radius)
- Proper keyboard types (numeric for pilot IDs)

## Screen 3: Success Alert

**Visual Layout:**
- **Modal Overlay:**
  - Semi-transparent dark background
  - Centered white card with rounded corners
  
- **Alert Content:**
  - Large green checkmark icon at top
  - "Registration Successful" title
  - "Your flight has been registered successfully." message
  - Single "OK" button at bottom

**Design Elements:**
- Clean, minimal design
- High contrast text
- Clear visual hierarchy
- Easy-to-tap button

## Screen 4: Error Alert

**Visual Layout:**
- **Modal Overlay:**
  - Semi-transparent dark background
  - Centered white card with rounded corners
  
- **Alert Content:**
  - Large red X icon at top
  - "Registration Error" title
  - Specific error message explaining the issue
  - Single "OK" button at bottom

## Typography Hierarchy

**Font Sizes and Weights:**
1. **App Title**: 24pt Bold (Home screen)
2. **Screen Title**: 20pt Bold (Registration screen)
3. **Section Headers**: 18pt Semibold
4. **Field Labels**: 18pt Medium
5. **Input Text**: 18pt Regular
6. **Button Text**: 20pt Semibold
7. **Body Text**: 16pt Regular
8. **Caption Text**: 14pt Regular

## Spacing and Layout

**Consistent Spacing:**
- **Screen Padding**: 20pt on all sides
- **Section Spacing**: 24pt between major sections
- **Field Spacing**: 16pt between form fields
- **Button Spacing**: 15pt between action buttons
- **Card Padding**: 16pt inside cards

**Touch Targets:**
- **Minimum Button Height**: 50pt
- **Primary Button Height**: 60pt
- **Input Field Height**: 50pt
- **Icon Size**: 24pt for section headers, 60pt for main icons

## Accessibility Features

**Visual Accessibility:**
- High contrast ratios (4.5:1 minimum)
- Large, clear fonts
- Consistent color usage
- Clear visual hierarchy

**Interaction Accessibility:**
- Large touch targets
- Clear focus indicators
- VoiceOver support
- Dynamic Type support
- Keyboard navigation support

**Content Accessibility:**
- Clear, descriptive labels
- Helpful placeholder text
- Error messages with guidance
- Success confirmations
