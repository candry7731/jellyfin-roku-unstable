sub init()
    m.buttonBackground = m.top.findNode("buttonBackground")
    m.buttonIcon = m.top.findNode("buttonIcon")
    m.buttonText = m.top.findNode("buttonText")

    m.buttonText.visible = false

    m.originalWidth = 0

    m.top.observeField("background", "sob_onBackgroundChanged")
    m.top.observeField("icon", "sob_onIconChanged")
    m.top.observeField("text", "sob_onTextChanged")
    m.top.observeField("height", "sob_onHeightChanged")
    m.top.observeField("width", "sob_onWidthChanged")
    m.top.observeField("padding", "sob_onPaddingChanged")
    m.top.observeField("focusedChild", "sob_onFocusChanged")

    m.top.observeField("highlighted", "sob_onHighlightChanged")
end sub

sub sob_onFocusChanged()
    if m.top.hasFocus()
        m.buttonText.visible = true
        m.buttonBackground.blendColor = m.top.focusBackground
        m.top.width = 250
    else
        m.buttonText.visible = false
        m.top.width = m.originalWidth
        sob_onHighlightChanged()
    end if
end sub

sub sob_onHighlightChanged()
    if m.top.highlighted
        m.buttonBackground.blendColor = m.top.highlightBackground
    else
        m.buttonBackground.blendColor = m.top.background
    end if
end sub

sub sob_onBackgroundChanged()
    m.buttonBackground.blendColor = m.top.background
    m.top.unobserveField("background")
end sub

sub sob_onIconChanged()
    m.buttonIcon.uri = m.top.icon
end sub

sub sob_onTextChanged()
    m.buttonText.text = m.top.text
end sub

sub sob_setIconSize()
    height = m.buttonBackground.height
    width = m.buttonBackground.width
    if height > 0 and width > 0
        ' TODO: Use smallest number between them
        m.buttonIcon.height = m.top.height

        if m.top.padding > 0
            m.buttonIcon.height = m.buttonIcon.height - m.top.padding
        end if

        m.buttonIcon.width = m.buttonIcon.height

        m.buttonIcon.translation = [m.top.padding, ((height - m.buttonIcon.height) / 2)]
        m.buttonText.translation = [m.top.padding + m.buttonIcon.width + 10, 12]
    end if
end sub

sub sob_onHeightChanged()
    m.buttonBackground.height = m.top.height
    sob_setIconSize()
end sub

sub sob_onWidthChanged()
    if m.originalWidth = 0
        m.originalWidth = m.top.width
    end if

    m.buttonBackground.width = m.top.width
    sob_setIconSize()
end sub

sub sob_onPaddingChanged()
    sob_setIconSize()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "OK" and m.top.hasFocus()
        ' Simply toggle the selected field to trigger the next event
        m.top.selected = not m.top.selected
        return true
    end if

    return false
end function
