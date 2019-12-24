package nom.brunokarpo.playing.app

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication


@SpringBootApplication
class PlayingApplication

fun main(args: Array<String>) {
    runApplication<PlayingApplication>(*args)
}