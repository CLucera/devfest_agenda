import 'package:devfest_agenda/helpers/api_helper.dart';
import 'package:devfest_agenda/main.dart';
import 'package:devfest_agenda/models/devfest_model.dart';
import 'package:devfest_agenda/ui/assistant_sheet.dart';
import 'package:devfest_agenda/ui/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'hat_map_widget.dart';

const _kDesktopSize = 1500.0;
const _kTabletSize = 800.0;
final GlobalKey<ScaffoldState> _key = GlobalKey();

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  bool showMap = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isDesktop = constraints.maxWidth >= _kDesktopSize;
      bool isTablet = constraints.maxWidth >= _kTabletSize;

      return Scaffold(
        key: _key,
        appBar: AppBar(
          title: const Text("Devfests 2024"),
          actions: [
            if (!isTablet)
              IconButton(
                onPressed: () {
                  setState(() => showMap = !showMap);
                },
                icon: Icon(showMap ? Icons.list : Icons.map),
              ),
          ],
        ),
        endDrawer: !isDesktop
            ? Container(
                alignment: AlignmentDirectional.centerEnd,
                constraints: const BoxConstraints(maxWidth: 400),
                child: const AssistantSheet(),
              )
            : null,
        body: Row(
          children: [
            Expanded(
              child: !isTablet && showMap
                  ? const MapWidget()
                  : FutureBuilder<List<DevfestModel>>(
                      future: listDevfests(),
                      builder: (context, snapshot) {
                        final devfests = snapshot.data;
                        if (devfests == null) {
                          return const CircularProgressIndicator();
                        }
                        return ListView.builder(
                          itemCount: devfests.length,
                          itemBuilder: (context, index) {
                            return DevfestListTile(devfest: devfests[index]);
                          },
                        );
                      }),
            ),
            AnimatedSize(
              duration: Durations.short2,
              curve: Curves.easeInOut,
              child: isTablet
                  ? SizedBox(
                      width: constraints.maxWidth / 2,
                      child: const MapWidget(),
                    )
                  : const SizedBox.shrink(),
            ),
            AnimatedSize(
              duration: Durations.short2,
              curve: Curves.easeInOut,
              child: isDesktop
                  ? const SizedBox(
                      width: 500,
                      child: AssistantSheet(),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        floatingActionButton: !isDesktop
            ? FloatingActionButton(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  final scaffold = _key.currentState;
                  if (scaffold != null) {
                    if (scaffold.isEndDrawerOpen) {
                      scaffold.closeEndDrawer();
                    } else {
                      scaffold.openEndDrawer();
                    }
                  }
                },
                child: const Icon(Icons.chat),
              )
            : null,
      );
    });
  }
}

class DevfestListTile extends StatefulWidget {
  final DevfestModel devfest;

  const DevfestListTile({
    required this.devfest,
    super.key,
  });

  @override
  State<DevfestListTile> createState() => _DevfestListTileState();
}

class _DevfestListTileState extends State<DevfestListTile> {
  @override
  void initState() {
    super.initState();
    appNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final monthFormat = DateFormat(DateFormat.ABBR_MONTH);

    return GestureDetector(
      onTap: () {
        appNotifier.select([widget.devfest]);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: appNotifier.selectedDevfests.contains(widget.devfest)
            ? colorScheme.inversePrimary
            : colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsetsDirectional.symmetric(
          vertical: 5.0,
          horizontal: 12.0,
        ),
        elevation: 2,
        child: SizedBox(
          height: 80.0,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ColoredBox(
                  color: colorScheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.devfest.startTime.day.toString(),
                        style: textTheme.titleLarge?.apply(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        monthFormat.format(widget.devfest.startTime),
                        style: textTheme.titleSmall?.apply(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.devfest.name,
                      style: textTheme.bodyLarge?.apply(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    if (widget.devfest.url != null)
                      Text(
                        widget.devfest.url!,
                        style: textTheme.labelSmall?.apply(
                          color: colorScheme.onPrimaryFixedVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
