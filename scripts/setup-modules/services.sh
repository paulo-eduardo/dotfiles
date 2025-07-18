#!/bin/bash

start_service_with_retry() {
    local service_name=$1
    local start_command=$2
    local max_attempts=30
    local attempt=1
    
    echo "Starting $service_name..."
    
    while [ $attempt -le $max_attempts ]; do
        if $start_command 2>/dev/null; then
            echo "✓ $service_name started successfully!"
            return 0
        else
            if [ $attempt -eq 1 ]; then
                echo "⚠️  $service_name requires permissions. Please grant access in the System Settings popup."
                echo "   Waiting for you to grant permissions..."
            fi
            echo -n "   Attempt $attempt/$max_attempts..."
            sleep 2
            echo " retrying"
            ((attempt++))
        fi
    done
    
    echo "❌ Failed to start $service_name after $max_attempts attempts."
    echo "   You may need to start it manually later with: $start_command"
    return 1
}

start_all_services() {
    echo ""
    echo "Services will attempt to start. You may see permission popups."
    echo "Grant the requested permissions when prompted."
    echo ""
    
    start_service_with_retry "yabai" "yabai --start-service"
    start_service_with_retry "skhd" "skhd --start-service"
    start_service_with_retry "sketchybar" "brew services start sketchybar"
    
    echo ""
    echo "If any services failed to start:"
    echo "1. Grant permissions in System Settings > Privacy & Security > Accessibility"
    echo "2. For yabai, also check System Settings > Privacy & Security > Screen Recording"
    echo "3. Run the start commands manually once permissions are granted"
}

stop_all_services() {
    echo "Stopping services..."
    
    echo "Stopping yabai..."
    yabai --stop-service 2>/dev/null || true
    
    echo "Stopping skhd..."
    skhd --stop-service 2>/dev/null || true
    
    echo "Stopping sketchybar..."
    brew services stop sketchybar 2>/dev/null || true
}