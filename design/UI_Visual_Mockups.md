# Glider Tow App - Visual UI Mockups

## Home Screen Layout

```
┌─────────────────────────────────────────┐
│              🛩️ Glider Tow              │
│           Registration App              │
│                                         │
│        Register your flight details     │
│                                         │
│                                         │
│  ┌─────────────────────────────────────┐ │
│  │  ➕ New Flight Registration         │ │
│  │                                     │ │
│  └─────────────────────────────────────┘ │
│                                         │
│  Recent Registrations                   │
│  ┌─────────────────────────────────────┐ │
│  │ Tow: ZK-ABC    📅 Dec 15, 2:30 PM  │ │
│  │ Glider: ZK-GLD                      │ │
│  │ Primary Pilot: 1234                 │ │
│  └─────────────────────────────────────┘ │
│                                         │
└─────────────────────────────────────────┘
```

## Registration Form Screen

```
┌─────────────────────────────────────────┐
│  ✕ Cancel                    🛩️        │
│                                         │
│         Flight Registration             │
│                                         │
│  🛩️ Tow Plane Details                  │
│  ┌─────────────────────────────────────┐ │
│  │ Tow Plane Registration              │ │
│  │ ┌─────────────────────────────────┐ │ │
│  │ │ Enter tow plane registration... │ │ │
│  │ └─────────────────────────────────┘ │ │
│  │                                     │ │
│  │ Tow Plane Pilot Name                │ │
│  │ ┌─────────────────────────────────┐ │ │
│  │ │ Enter pilot's full name...      │ │ │
│  │ └─────────────────────────────────┘ │ │
│  └─────────────────────────────────────┘ │
│                                         │
│  🛩️ Glider Details                     │
│  ┌─────────────────────────────────────┐ │
│  │ Glider Registration                 │ │
│  │ ┌─────────────────────────────────┐ │ │
│  │ │ Enter glider registration...    │ │ │
│  │ └─────────────────────────────────┘ │ │
│  └─────────────────────────────────────┘ │
│                                         │
│  👥 Glider Pilots                       │
│  ┌─────────────────────────────────────┐ │
│  │ Primary Pilot ID (Billing)          │ │
│  │ ┌─────────────────────────────────┐ │ │
│  │ │ Enter 4-digit pilot ID...       │ │ │
│  │ └─────────────────────────────────┘ │ │
│  │                                     │ │
│  │ Secondary Pilot ID (Optional)       │ │
│  │ ┌─────────────────────────────────┐ │ │
│  │ │ Enter 4-digit pilot ID...       │ │ │
│  │ └─────────────────────────────────┘ │ │
│  └─────────────────────────────────────┘ │
│                                         │
│  ┌─────────────────────────────────────┐ │
│  │  ✅ Register Flight                 │ │
│  └─────────────────────────────────────┘ │
│                                         │
│  ┌─────────────────────────────────────┐ │
│  │  🗑️ Clear Form                      │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

## Success Screen (Alert)

```
┌─────────────────────────────────────────┐
│                                         │
│              ✅ Success!                │
│                                         │
│        Registration Successful          │
│                                         │
│    Your flight has been registered      │
│            successfully.                │
│                                         │
│  ┌─────────────────────────────────────┐ │
│  │              OK                     │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

## Color Scheme & Typography

### Colors Used:
- **Background**: White (#FFFFFF)
- **Primary Text**: Dark Gray (#333333) 
- **Secondary Text**: Medium Gray (#666666)
- **Primary Button**: Blue (#007AFF)
- **Secondary Button**: Light Gray (#E5E5E5)
- **Input Fields**: Light Gray (#F5F5F5)
- **Success**: Green (#34C759)
- **Error**: Red (#FF3B30)

### Font Sizes:
- **App Title**: 24pt Bold
- **Section Headers**: 20pt Semibold
- **Field Labels**: 18pt Medium
- **Input Text**: 18pt Regular
- **Button Text**: 20pt Semibold

## Accessibility Features

### Visual Design:
- **High Contrast**: Dark text on light backgrounds
- **Large Touch Targets**: 50-60pt minimum button height
- **Clear Spacing**: 20pt padding, 16pt between fields
- **Consistent Icons**: SF Symbols for universal recognition

### Interaction Design:
- **Form Validation**: Real-time feedback on input
- **Clear Error Messages**: Specific guidance for corrections
- **Success Confirmation**: Clear feedback on completion
- **Easy Navigation**: Cancel/Back options always available

## Screen Flow

```
Home Screen
    ↓ [New Flight Registration]
Registration Form
    ↓ [Register Flight]
Success Alert
    ↓ [OK]
Back to Home Screen
```

## Key UI Elements

### Custom Text Field Component:
- Large, clear labels above input fields
- Rounded corners (10pt radius)
- Light gray background for contrast
- 18pt font size for readability
- Proper keyboard types (numeric for pilot IDs)

### Section Headers:
- Icon + title combination
- Blue accent color for icons
- Clear visual separation between sections
- Consistent spacing and alignment

### Action Buttons:
- Primary button: Blue background, white text
- Secondary button: Light gray background, red text
- Full-width design for easy tapping
- 50-60pt height for accessibility
- Clear visual hierarchy
