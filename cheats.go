

// Read only channel
func dowork(done <-chan bool) {
	for {
		select {
		case <-done:
			break
		default:
			fmt.Println("doing work")
		}
	}
}

func example() {
	atomic.AddInt32()
	done := make(chan bool)
	dowork(done)
	time.Sleep(time.Second * 5)
	close(done)
}
