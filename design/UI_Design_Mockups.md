# Glider Tow Registration App - UI Design

## Design Principles for Aged Users
- **Large, clear fonts** (minimum 18pt)
- **High contrast colors** (dark text on light backgrounds)
- **Simple, uncluttered layout**
- **Clear visual hierarchy**
- **Large touch targets** (minimum 44pt)
- **Consistent navigation patterns**

## Main Screen Layout

### Header
- App Title: "Glider Tow Registration"
- Large, bold font (24pt)
- Centered alignment

### Form Fields (Vertical Stack)

#### 1. Tow Plane Section
- **Label**: "Tow Plane Registration"
- **Input Field**: Large text field with placeholder "Enter tow plane registration (e.g., ZK-ABC)"
- **Label**: "Tow Plane Pilot Name"
- **Input Field**: Large text field with placeholder "Enter pilot's full name"

#### 2. Glider Section
- **Label**: "Glider Registration"
- **Input Field**: Large text field with placeholder "Enter glider registration (e.g., ZK-GLD)"

#### 3. Glider Pilots Section
- **Label**: "Primary Pilot (Billing)"
- **Input Field**: Large text field with placeholder "Enter 4-digit pilot ID"
- **Label**: "Secondary Pilot (Optional)"
- **Input Field**: Large text field with placeholder "Enter 4-digit pilot ID"

### Action Buttons
- **Submit Button**: Large, prominent button with "Register Flight" text
- **Clear Button**: Secondary button with "Clear Form" text

## Visual Design Specifications

### Colors
- **Primary Background**: White (#FFFFFF)
- **Secondary Background**: Light Gray (#F5F5F5)
- **Primary Text**: Dark Gray (#333333)
- **Secondary Text**: Medium Gray (#666666)
- **Primary Button**: Blue (#007AFF)
- **Secondary Button**: Light Gray (#E5E5E5)
- **Error Text**: Red (#FF3B30)
- **Success Text**: Green (#34C759)

### Typography
- **Headers**: System Bold, 24pt
- **Labels**: System Medium, 18pt
- **Input Text**: System Regular, 18pt
- **Button Text**: System Medium, 20pt

### Spacing
- **Section Spacing**: 24pt between major sections
- **Field Spacing**: 16pt between form fields
- **Padding**: 20pt around all content
- **Button Height**: 50pt minimum

## Screen Flow

1. **Main Registration Screen**: Primary form entry
2. **Confirmation Screen**: Review entered details
3. **Success Screen**: Confirmation of successful registration
4. **Error Handling**: Clear error messages with guidance

## Accessibility Features
- VoiceOver support for all elements
- Dynamic Type support for text scaling
- High contrast mode compatibility
- Large touch targets for easy interaction
- Clear focus indicators
